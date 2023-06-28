import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:prontuario/models/event_model.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';

part 'calendar_controller.g.dart';

class CalendarController = _CalendarController with _$CalendarController;

abstract class _CalendarController with Store {
  _CalendarController({required this.firebaseRepository});

  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final FirebaseRepository firebaseRepository;

  late PatientModel _patient;
  late EventModel _event;

  String idPatient = '';
  String idEvent = '';
  bool isEdit = false;

  List<PatientModel> listPatients = [];

  @observable
  CalendarFormat calendarFormat = CalendarFormat.month;

  @observable
  DateTime dateFocused = DateTime.now();

  @observable
  DateTime dateSelected = DateTime.now();

  @observable
  PageState pageState = PageState.success;

  @observable
  String errorMessage = '';

  @observable
  String formText = 'Agendar Consulta';

  @observable
  late List<EventModel> selectedEvents =
      events[DateTime(dateSelected.year, dateSelected.month, dateSelected.day)] ?? [];

  Map<DateTime, List<EventModel>> events = {
    DateTime(2020, 5, 22): [
      EventModel(date: DateTime(2020, 5, 22), info: ''),
    ]
  };

  @action
  Future<void> initialState({bool isNewEvent = false}) async {
    clearForm();
    if (isNewEvent || events.length <= 1) {
      await _getEvents();
    }
    dateSelected = DateTime.now();
    dateController.text = DateFormat('dd/MM/yyyy').format(dateSelected);
    getEventsForDay(dateSelected);
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> deleteEvent(String id) async {
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseDeleteEvent(id)).fold((l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {changePageState(PageState.success), initialState(isNewEvent: true)});
  }

  @action
  Future<void> loadEvent(EventModel event) async {
    isEdit = true;
    formText = 'Editar Agendamento';
    idEvent = event.idEvent!;
    idPatient = event.idPatient ?? '';
    patientNameController.text = "${event.patient?.name} ${event.patient?.surname} ";
    infoController.text = event.info;
    dateController.text = DateFormat('dd/MM/yyyy').format(event.date);
    hourController.text = DateFormat('HH:mm').format(event.date);
  }

  @action
  void changeCalendarFormat(CalendarFormat format) {
    calendarFormat = format;
  }

  @action
  void getEventsForDay(DateTime day) {
    selectedEvents = events[DateTime(day.year, day.month, day.day)] ?? [];
    selectedEvents.sort((a, b) => a.date.compareTo(b.date));
  }

  @action
  List<EventModel> loadEventsPerDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @action
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    clearForm();
    dateSelected = selectedDay;
    dateFocused = focusedDay;
    dateController.text = DateFormat('dd/MM/yyyy').format(selectedDay);
    getEventsForDay(selectedDay);
  }

  @action
  Future<void> _getEvents() async {
    changePageState(PageState.loading);
    clearForm();
    late DateTime dateKey;
    events.clear();
    (await firebaseRepository.firebaseGetAllEvents()).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {
              if (r.isNotEmpty)
                {
                  for (var i in r)
                    {
                      dateKey = DateTime(i.date.year, i.date.month, i.date.day),
                      if (events.containsKey(dateKey))
                        {events[dateKey]?.add(i)}
                      else
                        {
                          events[dateKey] = [i],
                        }
                    }
                },
              changePageState(PageState.success)
            });
  }

  Future<void> persistEvent() async {
    changePageState(PageState.loading);
    _event = EventModel(
        date: DateFormat("dd/MM/yyy HH:mm").parse('${dateController.text} ${hourController.text}'),
        idPatient: idPatient,
        info: infoController.text,
        idEvent: isEdit ? idEvent : '');
    if (isEdit) {
      (await firebaseRepository.firebaseUpdateEvent(_event)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {changePageState(PageState.success), initialState(isNewEvent: true)});
    } else {
      (await firebaseRepository.firebaseInsertEvent(_event)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {changePageState(PageState.success), initialState(isNewEvent: true)});
    }
  }

  @action
  Future<void> searchPatient(String fullname) async {
    changePageState(PageState.loading);
    listPatients = [];
    (await firebaseRepository.firebaseGetAllPatients(filterFullname: fullname)).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {
              listPatients = r,
              if (listPatients.length == 1) {changePatient(listPatients.first)},
              changePageState(PageState.success)
            });
  }

  @action
  Future<void> changePatient(PatientModel patient) async {
    _patient = patient;
    idPatient = _patient.idPatient!;
    patientNameController.text = _patient.fullname;
    _patient.dateBorn == null ? '' : DateFormat('dd/MM/yyyy').format(_patient.dateBorn!);
  }

  void clearForm() {
    isEdit = false;
    idEvent = '';
    idPatient = '';
    patientNameController.text = "";
    infoController.text = '';
    dateController.text = '';
    hourController.text = '';
    formText = 'Agendar Consulta';
  }

  bool verifyPatient() {
    return patientNameController.text == _patient.fullname;
  }

  String? validatePatient(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um paciente.';
    } else if (idPatient == '' || patientNameController.text != _patient.fullname) {
      return 'Paciente não encontrado.';
    }
    return null;
  }

  bool isError() => pageState == PageState.error ? true : false;

  bool isLoading() => pageState == PageState.loading ? true : false;
}
