import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/functionalities/patient_popup/view/patient_popup_page.dart';
import 'package:prontuario/widgets/c_app_bar.dart';
import 'package:prontuario/shared/constants/functions.dart';
import 'package:prontuario/shared/constants/validator.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import 'package:prontuario/widgets/c_elevated_button.dart';
import 'package:prontuario/widgets/c_icon_button.dart';
import 'package:prontuario/widgets/c_text_form_field.dart';
import '../../../widgets/c_bottom_bar.dart';
import '../../../widgets/c_drawer.dart';
import '../../../widgets/c_stack.dart';
import '../controller/appointment_controller.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({this.id = '', this.patientId = '', required this.mode, Key? key}) : super(key: key);
  final String? id;
  final String? mode;
  final String? patientId;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final appointmentController = Modular.get<AppointmentController>();
  final FocusNode appointmentDateFocus = FocusNode();
  final GlobalKey<FormState> formKeyAppointment = GlobalKey<FormState>();

  @override
  void initState() {
    appointmentController.isUserLogged()
        ? appointmentController.initialState(widget.id ?? '', widget.mode!, widget.patientId ?? '')
        : Modular.to.pushReplacementNamed(Modular.initialRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: const CBottomBar(),
        drawer: const CDrawer(actualPage: 'appointment'),
        appBar: CAppBar(title: 'Consulta'),
        body: Observer(
            builder: (_) => SingleChildScrollView(
                  child: Center(
                    child: Form(
                  key: formKeyAppointment,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CStack(
                        height: 600,
                        text: appointmentController.titleText,
                        children: <Widget>[
                          const SizedBox(height: 16),
                          CTextFormField(
                              focusNode: appointmentDateFocus,
                              isEnabled: appointmentController.isFieldEnabled(),
                              text: 'Data da Consulta',
                              hintText: 'dd/mm/aaaa',
                              controller: appointmentController.dateAppointmentController,
                              textInputAction: TextInputAction.next,
                              inputFormatter: Validator.inputDateTime(),
                              validator: Validator.validateDate,
                              suffixIcon: CIconButton(
                                  tooltipText: 'Escolher uma data',
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    datePicker(appointmentController.dateAppointmentController, context);
                                    appointmentDateFocus.requestFocus();
                                  })),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: CTextFormField(
                                    text: 'Paciente',
                                    isEnabled: appointmentController.isFieldEnabled(),
                                    controller: appointmentController.patientNameController,
                                    textInputAction: TextInputAction.next,
                                    validator: appointmentController.validatePatient,
                                    suffixIcon: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CIconButton(
                                            icon: const Icon(Icons.search),
                                            onPressed: () async {
                                              await appointmentController.searchPatient(
                                                  appointmentController.patientNameController.text);
                                              if (appointmentController.listPatients.length > 1 &&
                                                  context.mounted) {
                                                showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return PatientPopupPage(
                                                              fullname: appointmentController
                                                                  .patientNameController.text);
                                                        })
                                                    .then((value) => {
                                                          value != null
                                                              ? appointmentController.changePatient(value)
                                                              : null
                                                        });
                                              } else if (appointmentController.listPatients.isEmpty) {
                                                showSnackBar(context, false, 'Paciente não encontrado.');
                                              }
                                            },
                                            tooltipText: 'Buscar Paciente'),
                                        CIconButton(
                                          tooltipText: 'Escolher um paciente',
                                          icon: const Icon(Icons.person),
                                          onPressed: () async {
                                            showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return const PatientPopupPage();
                                                    })
                                                .then((value) => {
                                                      value != null
                                                          ? appointmentController.changePatient(value)
                                                          : null
                                                    });
                                          },
                                        ),
                                      ],
                                    )),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: CTextFormField(
                                  isEnabled: false,
                                  text: 'Data de Nascimento',
                                  controller: appointmentController.patientDateBornController,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          CTextFormField(
                            isEnabled: appointmentController.isFieldEnabled(),
                            text: 'Dados',
                            minLines: 15,
                            controller: appointmentController.dataAppointmentController,
                            textInputAction: TextInputAction.newline,
                          ),
                          const SizedBox(height: 30),
                          !appointmentController.isLoading()
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: appointmentController.isFieldVisible(),
                                      child: CElevatedButton(
                                          tooltipText: 'Salvar e finalizar consulta.',
                                          text: 'Finalizar',
                                          function: () async {
                                            if (formKeyAppointment.currentState!.validate()) {
                                              await appointmentController.persistAppointment(isParcial: false);
                                              if (context.mounted) {
                                                !appointmentController.isError()
                                                    ? showSnackBar(
                                                        context, true, 'Consulta cadastrada com sucesso.')
                                                    : showSnackBar(
                                                        context, false, appointmentController.errorMessage);
                                              }
                                            }
                                          },
                                          width: 80 + (MediaQuery.of(context).size.width / 12)),
                                    ),
                                    Visibility(
                                        visible: appointmentController.isFieldVisible(), child: const Spacer()),
                                    Visibility(
                                      visible: appointmentController.isFieldVisible(),
                                      child: CElevatedButton(
                                        tooltipText: 'Salvar e continuar consulta.',
                                        width: 80 + (MediaQuery.of(context).size.width / 12),
                                        text: 'Salvar',
                                        function: () async {
                                          if (formKeyAppointment.currentState!.validate()) {
                                            await appointmentController.persistAppointment(isParcial: true);
                                            if (context.mounted) {
                                              !appointmentController.isError()
                                                  ? showSnackBar(context, true, 'Consulta salva com sucesso.')
                                                  : showSnackBar(
                                                      context, false, appointmentController.errorMessage);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Visibility(
                                        visible: appointmentController.isFieldVisible(), child: const Spacer()),
                                    Visibility(
                                      visible: appointmentController.isFieldVisible(),
                                      child: CElevatedButton(
                                        tooltipText: 'Limpar formulário.',
                                        width: 80 + (MediaQuery.of(context).size.width / 12),
                                        text: 'Limpar',
                                        function: () {
                                          appointmentController.clearForm();
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : const CCircularProgressIndicator()
                        ],
                      ),
                    ],
                  ),
                    ),
                  ),
                )));
  }
}
