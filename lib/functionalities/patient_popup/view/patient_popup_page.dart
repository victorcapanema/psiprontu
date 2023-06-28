import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/widgets/c_icon_button.dart';
import 'package:prontuario/shared/constants/c_data_table_sources.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import '../../../widgets/c_stack.dart';
import '../controller/patient_popup_controller.dart';

class PatientPopupPage extends StatefulWidget {
  const PatientPopupPage({this.fullname = '', Key? key}) : super(key: key);
  final String? fullname;

  @override
  State<PatientPopupPage> createState() => _PatientPopupState();
}

class _PatientPopupState extends State<PatientPopupPage> {
  final patientPopupController = Modular.get<PatientPopupController>();

  @override
  void initState() {
    patientPopupController.initialState(widget.fullname!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.1),
        body: Observer(
            builder: (_) => SingleChildScrollView(
                    child: Stack(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (patientPopupController.isError())
                              Text(
                                patientPopupController.errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            if (patientPopupController.isLoading()) const CCircularProgressIndicator(),
                            if (patientPopupController.isSuccess())
                              Flexible(
                                child: CStack(width: 800, text: 'Consulta de Pacientes', children: [
                                  PaginatedDataTable(
                                      header: Align(
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          width: 200,
                                          height: 40,
                                          child: TextFormField(
                                              controller: patientPopupController.patientNameController,
                                              decoration: InputDecoration(
                                                labelStyle: const TextStyle(color: Colors.black),
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 1, color: Colors.black),
                                                    borderRadius: BorderRadius.circular(10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 1, color: Colors.black),
                                                    borderRadius: BorderRadius.circular(10)),
                                                suffixIcon: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CIconButton(
                                                        icon: const Icon(Icons.search, color: Colors.black),
                                                        tooltipText: 'Filtrar por Nome (completo)',
                                                        onPressed: () {
                                                          patientPopupController.getListPatientsFiltered(
                                                              name: patientPopupController.patientNameController.text);
                                                        }),
                                                    CIconButton(
                                                        icon: const Icon(Icons.clear, color: Colors.black),
                                                        tooltipText: 'Limpar filtros',
                                                        onPressed: () {
                                                          patientPopupController.getListPatients();
                                                        })
                                                  ],
                                                ),
                                                labelText: 'Nome',
                                              )),
                                        ),
                                      ),
                                      columns: [
                                        const DataColumn(label: Text('Selecionar')),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Nome'),
                                            IconButton(
                                                onPressed: () {
                                                  patientPopupController.sortList();
                                                },
                                                icon: patientPopupController.isUpwardPatient
                                                    ? const Icon(Icons.arrow_upward)
                                                    : const Icon(Icons.arrow_downward))
                                          ],
                                        )),
                                        const DataColumn(label: Text('CPF')),
                                        const DataColumn(label: Text('CID')),
                                      ],
                                      columnSpacing: 100,
                                      horizontalMargin: 10,
                                      rowsPerPage: 8,
                                      showCheckboxColumn: false,
                                      source: PatientSource(
                                          listPatients: patientPopupController.listPatients,
                                          isView: true,
                                          context: context)),
                                ]),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]))));
  }
}
