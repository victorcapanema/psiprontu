import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/shared/constants/c_data_table_sources.dart';
import 'package:prontuario/widgets/c_app_bar.dart';
import 'package:prontuario/shared/constants/c_data_columns.dart';
import 'package:prontuario/shared/constants/functions.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import 'package:prontuario/widgets/c_elevated_button.dart';
import 'package:prontuario/widgets/c_icon_button.dart';
import 'package:prontuario/widgets/c_text_form_field.dart';
import '../../../shared/constants/validator.dart';
import '../../../widgets/c_bottom_bar.dart';
import '../../../widgets/c_drawer.dart';
import '../../../widgets/c_stack.dart';
import '../controller/maintenance_controller.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final maintenanceController = Modular.get<MaintenanceController>();
  final FocusNode appointmentDateFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    maintenanceController.isUserLogged()
        ? maintenanceController.initialState()
        : Modular.to.pushReplacementNamed(Modular.initialRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CBottomBar(),
      drawer: const CDrawer(actualPage: 'maintenance'),
      appBar: CAppBar(title: 'Registros'),
      body: Observer(
        builder: (_) => SingleChildScrollView(
          child: Center(
            child: CStack(width: 1200, text: 'Visualizar Registros', children: [
              Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120 + (MediaQuery.of(context).size.width / 12),
                              child: DropdownButtonFormField<String>(
                                value: maintenanceController.dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Tipo de Registro',
                                  labelStyle: const TextStyle(color: Colors.black),
                                  enabledBorder: customOutlineInputBorder(Colors.black),
                                  focusedBorder: customOutlineInputBorder(Colors.black),
                                ),
                                onChanged: (String? value) {
                                  maintenanceController.changeDropDownValue(value!);
                                  if (value == 'Paciente') {
                                    maintenanceController.getListPatients();
                                  }
                                  if (value == 'Consulta') {
                                    maintenanceController.getListAppointments();
                                  }
                                  maintenanceController.isError()
                                      ? showSnackBar(context, false, maintenanceController.errorMessage)
                                      : null;
                                },
                                items: maintenanceController.entities.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            const Spacer(),
                            Form(
                              key: formKey,
                              child: CStack(
                                  width: 120 + (MediaQuery.of(context).size.width / 10),
                                  isPadding: true,
                                  isMargin: true,
                                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 4),
                                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  text: 'Filtros',
                                  children: [
                                    CTextFormField(
                                        text: 'Nome',
                                        controller: maintenanceController.nameFilterController,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: Validator.inputCapitalWords(),
                                        suffixIcon: CIconButton(
                                          icon: const Icon(
                                            Icons.search,
                                          ),
                                          tooltipText: 'Filtrar somente por Nome',
                                          onPressed: () async {
                                            switch (maintenanceController.dropdownValue) {
                                              case 'Paciente':
                                                await maintenanceController.getListPatientsFiltered(
                                                    name: maintenanceController.nameFilterController.text);
                                                break;
                                              case 'Consulta':
                                                await maintenanceController.getListAppointmentsFiltered(
                                                    name: maintenanceController.nameFilterController.text);
                                                break;
                                            }
                                          },
                                        )),
                                    const SizedBox(height: 8),
                                    CTextFormField(
                                        text: 'Sobrenome',
                                        controller: maintenanceController.surnameFilterController,
                                        textInputAction: TextInputAction.next,
                                        inputFormatter: Validator.inputCapitalWords(),
                                        suffixIcon: CIconButton(
                                            tooltipText: 'Filtrar somente por Sobrenome',
                                            icon: const Icon(
                                              Icons.search,
                                            ),
                                            onPressed: () async {
                                              switch (maintenanceController.dropdownValue) {
                                                case 'Paciente':
                                                  await maintenanceController.getListPatientsFiltered(
                                                      surname: maintenanceController.surnameFilterController.text);
                                                  break;
                                                case 'Consulta':
                                                  await maintenanceController.getListAppointmentsFiltered(
                                                      surname: maintenanceController.surnameFilterController.text);
                                                  break;
                                              }
                                            })),
                                    const SizedBox(height: 8),
                                    Visibility(
                                      visible: maintenanceController.isAppointmentFilter(),
                                      child: CTextFormField(
                                          focusNode: appointmentDateFocus,
                                          text: 'Data da Consulta',
                                          controller: maintenanceController.dateAppointmentController,
                                          textInputAction: TextInputAction.next,
                                          inputFormatter: Validator.inputDateTime(),
                                          validator: Validator.validateDate,
                                          suffixIcon: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CIconButton(
                                                  tooltipText: 'Escolher uma data',
                                                  icon: const Icon(
                                                    Icons.calendar_today,
                                                  ),
                                                  onPressed: () async {
                                                    datePicker(
                                                        maintenanceController.dateAppointmentController, context);
                                                    FocusScope.of(context).requestFocus(appointmentDateFocus);
                                                  }),
                                              CIconButton(
                                                tooltipText: 'Filtrar somente por Data da Consulta',
                                                icon: const Icon(
                                                  Icons.search,
                                                ),
                                                onPressed: () async {
                                                  if (formKey.currentState!.validate()) {
                                                    await maintenanceController.getListAppointmentsFiltered(
                                                        dateAppointment:
                                                            maintenanceController.dateAppointmentController.text);
                                                  }
                                                },
                                              )
                                            ],
                                          )),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: CElevatedButton(
                                              text: 'Todos Filtros',
                                              function: () async {
                                                switch (maintenanceController.dropdownValue) {
                                                  case 'Paciente':
                                                    await maintenanceController.getListPatientsFiltered(
                                                        name: maintenanceController.nameFilterController.text,
                                                        surname: maintenanceController.surnameFilterController.text);
                                                    break;
                                                  case 'Consulta':
                                                    if (maintenanceController.dateAppointmentController.text.isEmpty ||
                                                        formKey.currentState!.validate()) {
                                                      await maintenanceController.getListAppointmentsFiltered(
                                                          name: maintenanceController.nameFilterController.text,
                                                          surname: maintenanceController.surnameFilterController.text,
                                                          dateAppointment:
                                                              maintenanceController.dateAppointmentController.text);
                                                    }
                                                    break;
                                                }
                                              },
                                              width: 40 + (MediaQuery.of(context).size.width / 12)),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: CElevatedButton(
                                            width: 40 + (MediaQuery.of(context).size.width / 12),
                                            text: 'Limpar',
                                            function: () {
                                              maintenanceController.resetGrid();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 4,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                              ),
                              child: maintenanceController.isLoading()
                                  ? const CCircularProgressIndicator()
                                  : PaginatedDataTable(
                                      columns: getDataColumns(maintenanceController.dropdownValue,
                                          maintenanceController.listArrows, maintenanceController.sortList),
                                      columnSpacing: 100,
                                      horizontalMargin: 10,
                                      rowsPerPage: 8,
                                      showCheckboxColumn: false,
                                      header: Text(
                                        '${maintenanceController.dropdownValue.toUpperCase()}S',
                                        textAlign: TextAlign.center,
                                      ),
                                      source: maintenanceController.dropdownValue == 'Paciente'
                                          ? PatientSource(
                                              listPatients: maintenanceController.listPatients,
                                              context: context,
                                              functionDelete: maintenanceController.deleteRegister)
                                          : AppointmentSource(
                                              listAppointments: maintenanceController.listAppointments,
                                              context: context,
                                              functionDelete: maintenanceController.deleteRegister)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
