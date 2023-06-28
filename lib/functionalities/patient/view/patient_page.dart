import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/shared/colors/app_colors.dart';
import 'package:prontuario/shared/constants/entities.dart';
import 'package:prontuario/shared/constants/functions.dart';
import 'package:prontuario/shared/constants/validator.dart';
import 'package:prontuario/widgets/c_bottom_bar.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import 'package:prontuario/widgets/c_elevated_button.dart';
import 'package:prontuario/widgets/c_text_form_field.dart';
import 'package:prontuario/functionalities/patient/controller/patient_controller.dart';
import 'package:prontuario/widgets/c_app_bar.dart';
import '../../../widgets/c_drawer.dart';
import '../../../widgets/c_icon_button.dart';
import '../../../widgets/c_stack.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({this.id = '', required this.mode, Key? key}) : super(key: key);
  final String? id;
  final String? mode;

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final patientController = Modular.get<PatientController>();
  final GlobalKey<FormState> formKeyPatient = GlobalKey<FormState>();
  final GlobalKey<FormState> formResKey = GlobalKey<FormState>();

  final FocusNode bornDateFocus = FocusNode();
  final FocusNode startDateFocus = FocusNode();
  final FocusNode endDateFocus = FocusNode();

  @override
  void initState() {
    patientController.isUserLogged()
        ? patientController.initialPageState(widget.id ?? '', widget.mode!)
        : Modular.to.pushReplacementNamed(Modular.initialRoute);
    super.initState();
  }

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CBottomBar(),
      drawer: const CDrawer(actualPage: 'patient'),
      appBar: CAppBar(title: 'Paciente'),
      body: Observer(
          builder: (_) => SingleChildScrollView(
                child: Center(
                    child: Form(
                  key: formKeyPatient,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      CStack(
                        text: patientController.titleText,
                        children: <Widget>[
                          Row(
                            children: [
                              Flexible(
                                child: CTextFormField(
                                  isEnabled: patientController.isFieldEnabled(),
                                  text: 'Nome',
                                  controller: patientController.nameController,
                                  textInputAction: TextInputAction.next,
                                  inputFormatter: Validator.inputCapitalWords(),
                                  validator: Validator.validateEmpty,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: CTextFormField(
                                  isEnabled: patientController.isFieldEnabled(),
                                  text: 'Sobrenome',
                                  controller: patientController.surnameController,
                                  textInputAction: TextInputAction.next,
                                  inputFormatter: Validator.inputCapitalWords(),
                                  validator: Validator.validateEmpty,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(children: [
                            Flexible(
                              child: CTextFormField(
                                  focusNode: bornDateFocus,
                                  isEnabled: patientController.isFieldEnabled(),
                                  text: 'Data de Nascimento',
                                  hintText: 'dd/mm/aaaa',
                                  controller: patientController.dateBornController,
                                  textInputAction: TextInputAction.next,
                                  inputFormatter: Validator.inputDateTime(),
                                  validator: Validator.validateDate,
                                  suffixIcon: CIconButton(
                                      tooltipText: 'Escolher uma data',
                                      icon: const Icon(
                                        Icons.calendar_today,
                                      ),
                                      onPressed: () async {
                                        datePicker(patientController.dateBornController, context);
                                        bornDateFocus.requestFocus();
                                      })),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: CTextFormField(
                                isEnabled: patientController.isFieldEnabled(),
                                text: 'CPF',
                                controller: patientController.cpfController,
                                textInputAction: TextInputAction.next,
                                inputFormatter: Validator.inputCPF(),
                                validator: Validator.validateCpf,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 16),
                          CTextFormField(
                            isEnabled: patientController.isFieldEnabled(),
                            text: 'CID',
                            controller: patientController.cidController,
                            textInputAction: TextInputAction.next,
                            validator: Validator.validateEmpty,
                          ),
                          const SizedBox(height: 16),
                          Row(children: [
                            Flexible(
                              child: CTextFormField(
                                isEnabled: patientController.isFieldEnabled(),
                                text: 'Queixa Principal',
                                controller: patientController.complaintController,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: CTextFormField(
                                isEnabled: patientController.isFieldEnabled(),
                                text: 'Medicação',
                                controller: patientController.medicationController,
                                textInputAction: TextInputAction.next,
                              ),
                            )
                          ]),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: CTextFormField(
                                    focusNode: startDateFocus,
                                    isEnabled: patientController.isFieldEnabled(),
                                    text: 'Data Inicial do Tratamento',
                                    hintText: 'dd/mm/aaaa',
                                    controller: patientController.dateStartController,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: Validator.inputDateTime(),
                                    validator: Validator.validateDate,
                                    suffixIcon: CIconButton(
                                        tooltipText: 'Escolher uma data',
                                        icon: const Icon(
                                          Icons.calendar_today,
                                        ),
                                        onPressed: () async {
                                          datePicker(patientController.dateStartController, context);
                                          FocusScope.of(context).requestFocus(startDateFocus);
                                        })),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: CTextFormField(
                                    focusNode: endDateFocus,
                                    isEnabled: patientController.isFieldEnabled(),
                                    text: 'Data Final do Tratamento',
                                    hintText: 'dd/mm/aaaa',
                                    controller: patientController.dateEndController,
                                    textInputAction: TextInputAction.next,
                                    inputFormatter: Validator.inputDateTime(),
                                    validator: Validator.validateDateOptional,
                                    suffixIcon: CIconButton(
                                        icon: const Icon(
                                          Icons.calendar_today,
                                        ),
                                        onPressed: () async {
                                          datePicker(patientController.dateEndController, context);
                                          FocusScope.of(context).requestFocus(endDateFocus);
                                        },
                                        tooltipText: 'Escolher uma data')),
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          CTextFormField(
                              isEnabled: patientController.isFieldEnabled(),
                              text: 'Endereço',
                              controller: patientController.addressController,
                              textInputAction: TextInputAction.next,
                              inputFormatter: Validator.inputCapitalWords()),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: CTextFormField(
                                  isEnabled: patientController.isFieldEnabled(),
                                  text: 'Telefone',
                                  controller: patientController.phoneController,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              patientController.isFieldEnabled() ? Colors.black : AppColors.sleekGrey)),
                                  child: CheckboxListTile(
                                      enabled: patientController.isFieldEnabled(),
                                      title: const Text('Possui Responsável'),
                                      controlAffinity: ListTileControlAffinity.leading,
                                      activeColor: AppColors.forest,
                                      visualDensity: VisualDensity.compact,
                                      value: patientController.isChecked,
                                      shape: customOutlineInputBorder(Colors.black),
                                      onChanged: (value) {
                                        patientController.changeCheckState(value!);
                                      }),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          !patientController.isLoading()
                              ? Visibility(
                                  visible: !patientController.isChecked,
                                  child: buttons(),
                                )
                              : Visibility(
                                  visible: !patientController.isChecked, child: const CCircularProgressIndicator()),
                          const SizedBox(height: 16),
                        ],
                      ),
                      Visibility(
                        visible: patientController.isChecked,
                        child: CStack(text: 'Responsáveis', children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Form(
                              key: formResKey,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: patientController.isFieldEnabled(),
                                    child: Center(
                                      child: CIconButton(
                                          tooltipText: 'Mostrar / Esconder campos para cadastro',
                                          onPressed: () {
                                            patientController.changeExpandedState();
                                          },
                                          icon: const Icon(Icons.arrow_downward_rounded)),
                                    ),
                                  ),
                                  Visibility(
                                    visible: patientController.isExpanded,
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CTextFormField(
                                                isEnabled: patientController.isFieldEnabled(),
                                                text: 'Nome',
                                                controller: patientController.resNameController,
                                                textInputAction: TextInputAction.next,
                                                inputFormatter: Validator.inputCapitalWords(),
                                                validator: Validator.validateEmpty,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(
                                              child: CTextFormField(
                                                isEnabled: patientController.isFieldEnabled(),
                                                text: 'Sobrenome',
                                                controller: patientController.resSurnameController,
                                                textInputAction: TextInputAction.next,
                                                inputFormatter: Validator.inputCapitalWords(),
                                                validator: Validator.validateEmpty,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CTextFormField(
                                                isEnabled: patientController.isFieldEnabled(),
                                                text: 'CPF',
                                                controller: patientController.resCpfController,
                                                textInputAction: TextInputAction.next,
                                                inputFormatter: Validator.inputCPF(),
                                                validator: Validator.validateCpf,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(
                                              child: CTextFormField(
                                                isEnabled: patientController.isFieldEnabled(),
                                                text: 'Telefone',
                                                controller: patientController.resPhoneController,
                                                textInputAction: TextInputAction.next,
                                                validator: Validator.validateEmpty,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CElevatedButton(
                                                text: 'Adicionar',
                                                function: () {
                                                  if (formResKey.currentState!.validate()) {
                                                    patientController.updateResponsible();
                                                  }
                                                },
                                                width: MediaQuery.of(context).size.width / 10),
                                            const SizedBox(width: 16),
                                            CElevatedButton(
                                              width: MediaQuery.of(context).size.width / 10,
                                              text: 'Limpar',
                                              function: () {
                                                patientController.clearResForm();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.fromLTRB(4, 10, 4, 0),
                                        itemCount: patientController.responsibles.length,
                                        itemBuilder: (BuildContext context, int i) {
                                          return Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(width: 1),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: ListTile(
                                                leading: const Icon(Icons.person_sharp, color: AppColors.forest),
                                                title: Text(
                                                    '${patientController.responsibles[i].name} ${patientController.responsibles[i].surname}'),
                                                subtitle: Text(
                                                    '${patientController.responsibles[i].cpf} - ${patientController.responsibles[i].phone}'),
                                                trailing: patientController.isFieldEnabled()
                                                    ? PopupMenuButton<SampleItem>(
                                                        initialValue: selectedMenu,
                                                        onSelected: (SampleItem item) {
                                                          if (item == SampleItem.editar) {
                                                            patientController.loadResponsible(i);
                                                          } else if (item == SampleItem.desfazer) {
                                                            patientController.unMarkDeleteResponsible(i);
                                                          } else {
                                                            patientController.markDeleteResponsible(i);
                                                          }
                                                        },
                                                        itemBuilder: (BuildContext context) =>
                                                            <PopupMenuEntry<SampleItem>>[
                                                          const PopupMenuItem<SampleItem>(
                                                            value: SampleItem.editar,
                                                            child: Text('Editar'),
                                                          ),
                                                          const PopupMenuItem<SampleItem>(
                                                            value: SampleItem.excluir,
                                                            child: Text('Excluir'),
                                                          ),
                                                          if (patientController.responsibles[i].isDelete)
                                                            const PopupMenuItem<SampleItem>(
                                                                value: SampleItem.desfazer, child: Text('Desfazer'))
                                                        ],
                                                      )
                                                    : null,
                                                tileColor: tileColor(patientController.responsibles[i].isEdit,
                                                    patientController.responsibles[i].isDelete),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(width: 1),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          !patientController.isLoading()
                              ? Visibility(
                                  visible: patientController.isChecked,
                                  child: buttons(),
                                )
                              : Visibility(
                                  visible: patientController.isChecked, child: const CCircularProgressIndicator()),
                          const SizedBox(height: 16)
                        ]),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                )),
              )),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: patientController.isFieldVisible(),
          child: CElevatedButton(
              text: 'Confirmar',
              function: () async {
                if (formKeyPatient.currentState!.validate()) {
                  await patientController.persistPatient();
                  if (context.mounted) {
                    !patientController.isError()
                        ? showSnackBar(context, true, 'Paciente cadastrado com sucesso.')
                        : showSnackBar(context, false, patientController.errorMessage);
                  }
                }
              },
              width: 80 + (MediaQuery.of(context).size.width / 12)),
        ),
        Visibility(visible: patientController.isFieldVisible(), child: const Spacer()),
        Visibility(
          visible: patientController.isFieldVisible(),
          child: CElevatedButton(
            width: 80 + (MediaQuery.of(context).size.width / 12),
            text: 'Limpar',
            function: () {
              patientController.clearForm();
            },
          ),
        ),
        Visibility(visible: patientController.isFieldVisible(), child: const Spacer()),
        CElevatedButton(
          width: 80 + (MediaQuery.of(context).size.width / 12),
          text: 'Voltar',
          function: () {
            Modular.to.pushReplacementNamed('/homepage');
          },
        )
      ],
    );
  }
}
