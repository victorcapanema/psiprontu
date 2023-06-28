import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:prontuario/widgets/c_elevated_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:prontuario/shared/colors/app_colors.dart';
import 'package:prontuario/shared/constants/functions.dart';
import 'package:prontuario/shared/constants/validator.dart';
import 'package:prontuario/widgets/c_app_bar.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import 'package:prontuario/widgets/c_icon_button.dart';
import 'package:prontuario/widgets/c_text_form_field.dart';
import '../../../shared/constants/entities.dart';
import '../../../widgets/c_bottom_bar.dart';
import '../../../widgets/c_drawer.dart';
import '../../../widgets/c_stack.dart';
import '../../patient_popup/view/patient_popup_page.dart';
import '../controller/calendar_controller.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final calendarController = Modular.get<CalendarController>();
  final FocusNode dateFocus = FocusNode();
  final GlobalKey<FormState> formKeyCalendar = GlobalKey<FormState>();

  @override
  void initState() {
    calendarController.initialState();
    super.initState();
  }

  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CBottomBar(),
        drawer: const CDrawer(actualPage: 'calendar'),
        appBar: CAppBar(title: 'Agenda'),
        body: Observer(
          builder: (_) => SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Wrap(
                children: [
                  CStack(
                    width: 900,
                    height: 800,
                    text: 'Calendário',
                    children: [
                      TableCalendar(
                        calendarBuilders: CalendarBuilders(todayBuilder: (context, day, day2) {
                          return Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: AppColors.marine.withOpacity(0.6)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                              child: Text(
                                day.day.toString(),
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ));
                        }, selectedBuilder: (context, day, day2) {
                          return Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(color: AppColors.marine),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
                              child: Text(
                                day.day.toString(),
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ));
                        }, markerBuilder: (context, day, list) {
                          return list.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Container(
                                      decoration: const BoxDecoration(color: AppColors.forest),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        child: Text(
                                          '${list.length}',
                                          style: const TextStyle(color: Colors.white, fontSize: 13),
                                        ),
                                      )),
                                )
                              : null;
                        }),
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: calendarController.dateFocused,
                        calendarFormat: calendarController.calendarFormat,
                        locale: 'pt_BR',
                        eventLoader: calendarController.loadEventsPerDay,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Mês',
                          CalendarFormat.twoWeeks: '2 Semanas',
                          CalendarFormat.week: 'Semana'
                        },
                        onFormatChanged: calendarController.changeCalendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(calendarController.dateSelected, day);
                        },
                        onDaySelected: calendarController.onDaySelected,
                      ),
                      calendarController.isLoading()
                          ? const CCircularProgressIndicator()
                          : CStack(text: 'Consultas', children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(DateFormat.EEEE('pt_BR').format(calendarController.dateSelected)),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration:
                                            const BoxDecoration(color: AppColors.marine, shape: BoxShape.circle),
                                        child: Center(
                                          child: Text(
                                            calendarController.dateSelected.day.toString(),
                                            style: const TextStyle(fontSize: 20, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      height: calendarController.selectedEvents.length <= 3 ? 220 : 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 30, 50, 6),
                                          child: calendarController.selectedEvents.isEmpty
                                              ? const Text('Não há consultas agendadas neste dia.')
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: calendarController.selectedEvents.length,
                                                  itemBuilder: (context, index) {
                                                    return ListTile(
                                                      onTap: () => {
                                                        calendarController
                                                            .loadEvent(calendarController.selectedEvents[index])
                                                      },
                                                      title: Tooltip(
                                                        message: 'Editar',
                                                        waitDuration: const Duration(milliseconds: 500),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: AppColors.feather,
                                                            borderRadius: BorderRadius.circular(3),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(8, 4, 0, 6),
                                                            child: Stack(children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    DateFormat('HH:mm').format(
                                                                        calendarController.selectedEvents[index].date),
                                                                    style: const TextStyle(color: Colors.white),
                                                                  ),
                                                                  Text(
                                                                      "${calendarController.selectedEvents[index].patient?.name ?? ''} ${calendarController.selectedEvents[index].patient?.surname ?? ''}",
                                                                      style: const TextStyle(color: Colors.white)),
                                                                  if (calendarController
                                                                      .selectedEvents[index].info.isNotEmpty)
                                                                    Text(calendarController.selectedEvents[index].info,
                                                                        style: const TextStyle(color: Colors.white)),
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment: Alignment.centerRight,
                                                                child: PopupMenuButton<SampleItem>(
                                                                  initialValue: selectedMenu,
                                                                  onSelected: (SampleItem item) {
                                                                    if (item == SampleItem.editar) {
                                                                      calendarController.loadEvent(
                                                                          calendarController.selectedEvents[index]);
                                                                    } else if (item == SampleItem.excluir) {
                                                                      calendarController.deleteEvent(calendarController
                                                                          .selectedEvents[index].idEvent!);
                                                                      !calendarController.isError()
                                                                          ? showSnackBar(context, true,
                                                                              'Consulta desmarcada com sucesso')
                                                                          : showSnackBar(context, false,
                                                                              calendarController.errorMessage);
                                                                    } else if (item == SampleItem.atender) {
                                                                      Modular.to.pushNamed(
                                                                          '/appointmentPage?patientId=${calendarController.selectedEvents[index].idPatient}&mode=ins');
                                                                    }
                                                                  },
                                                                  itemBuilder: (BuildContext context) =>
                                                                      <PopupMenuEntry<SampleItem>>[
                                                                    const PopupMenuItem<SampleItem>(
                                                                      value: SampleItem.atender,
                                                                      child: Text('Atender'),
                                                                    ),
                                                                    const PopupMenuItem<SampleItem>(
                                                                      value: SampleItem.editar,
                                                                      child: Text('Editar'),
                                                                    ),
                                                                    const PopupMenuItem<SampleItem>(
                                                                      value: SampleItem.excluir,
                                                                      child: Text('Desmarcar'),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                    ],
                  ),
                  CStack(
                      width: 400,
                      text: calendarController.formText,
                      isMargin: true,
                      isPadding: true,
                      margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 4),
                      children: [
                        Form(
                          key: formKeyCalendar,
                          child: Column(
                            children: [
                              CTextFormField(
                                  text: 'Paciente',
                                  controller: calendarController.patientNameController,
                                  textInputAction: TextInputAction.next,
                                  validator: calendarController.validatePatient,
                                  suffixIcon: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CIconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () async {
                                            await calendarController
                                                .searchPatient(calendarController.patientNameController.text);
                                            if (calendarController.listPatients.length > 1 && context.mounted) {
                                              showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return PatientPopupPage(
                                                            fullname: calendarController.patientNameController.text);
                                                      })
                                                  .then((value) =>
                                                      {value != null ? calendarController.changePatient(value) : null});
                                            } else if (calendarController.listPatients.isEmpty) {
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
                                              .then((value) =>
                                                  {value != null ? calendarController.changePatient(value) : null});
                                        },
                                      ),
                                    ],
                                  )),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(children: [
                                Flexible(
                                    child: CTextFormField(
                                        text: 'Data',
                                        controller: calendarController.dateController,
                                        textInputAction: TextInputAction.next,
                                        hintText: 'dd/mm/aaaa',
                                        inputFormatter: Validator.inputDateTime(),
                                        validator: Validator.validateDate,
                                        suffixIcon: CIconButton(
                                          icon: const Icon(
                                            Icons.calendar_today,
                                          ),
                                          onPressed: () async {
                                            datePicker(calendarController.dateController, context);
                                            dateFocus.requestFocus();
                                          },
                                          tooltipText: 'Escolher uma data',
                                        ))),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.006),
                                Flexible(
                                    child: CTextFormField(
                                  text: 'Horario',
                                  controller: calendarController.hourController,
                                  textInputAction: TextInputAction.next,
                                  hintText: '00:00',
                                  inputFormatter: Validator.inputTime(),
                                  validator: Validator.validateHour,
                                ))
                              ]),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              CTextFormField(
                                  text: 'Observação',
                                  controller: calendarController.infoController,
                                  textInputAction: TextInputAction.next),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              calendarController.isLoading() && calendarController.isEdit
                                  ? const CCircularProgressIndicator()
                                  : Row(
                                      children: [
                                        const Spacer(),
                                        Flexible(
                                          child: CElevatedButton(
                                            tooltipText: 'Confirmar agendamento',
                                            text: 'Confirmar',
                                            function: () {
                                              if (formKeyCalendar.currentState!.validate()) {
                                                calendarController.persistEvent();
                                                !calendarController.isError()
                                                    ? showSnackBar(context, true, 'Paciente agendado com sucesso')
                                                    : showSnackBar(context, false, calendarController.errorMessage);
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        Flexible(
                                            child: CElevatedButton(
                                                tooltipText: 'Limpar formulário',
                                                text: 'Limpar',
                                                function: () {
                                                  calendarController.clearForm();
                                                })),
                                        const Spacer(),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ])
                ],
              ),
              const SizedBox(height: 8),
            ],
          )),
        ));
  }
}
