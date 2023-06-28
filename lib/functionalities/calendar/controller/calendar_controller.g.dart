// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarController on _CalendarController, Store {
  late final _$calendarFormatAtom =
      Atom(name: '_CalendarController.calendarFormat', context: context);

  @override
  CalendarFormat get calendarFormat {
    _$calendarFormatAtom.reportRead();
    return super.calendarFormat;
  }

  @override
  set calendarFormat(CalendarFormat value) {
    _$calendarFormatAtom.reportWrite(value, super.calendarFormat, () {
      super.calendarFormat = value;
    });
  }

  late final _$dateFocusedAtom =
      Atom(name: '_CalendarController.dateFocused', context: context);

  @override
  DateTime get dateFocused {
    _$dateFocusedAtom.reportRead();
    return super.dateFocused;
  }

  @override
  set dateFocused(DateTime value) {
    _$dateFocusedAtom.reportWrite(value, super.dateFocused, () {
      super.dateFocused = value;
    });
  }

  late final _$dateSelectedAtom =
      Atom(name: '_CalendarController.dateSelected', context: context);

  @override
  DateTime get dateSelected {
    _$dateSelectedAtom.reportRead();
    return super.dateSelected;
  }

  @override
  set dateSelected(DateTime value) {
    _$dateSelectedAtom.reportWrite(value, super.dateSelected, () {
      super.dateSelected = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_CalendarController.pageState', context: context);

  @override
  PageState get pageState {
    _$pageStateAtom.reportRead();
    return super.pageState;
  }

  @override
  set pageState(PageState value) {
    _$pageStateAtom.reportWrite(value, super.pageState, () {
      super.pageState = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CalendarController.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$formTextAtom =
      Atom(name: '_CalendarController.formText', context: context);

  @override
  String get formText {
    _$formTextAtom.reportRead();
    return super.formText;
  }

  @override
  set formText(String value) {
    _$formTextAtom.reportWrite(value, super.formText, () {
      super.formText = value;
    });
  }

  late final _$selectedEventsAtom =
      Atom(name: '_CalendarController.selectedEvents', context: context);

  @override
  List<EventModel> get selectedEvents {
    _$selectedEventsAtom.reportRead();
    return super.selectedEvents;
  }

  @override
  set selectedEvents(List<EventModel> value) {
    _$selectedEventsAtom.reportWrite(value, super.selectedEvents, () {
      super.selectedEvents = value;
    });
  }

  late final _$initialStateAsyncAction =
      AsyncAction('_CalendarController.initialState', context: context);

  @override
  Future<void> initialState({bool isNewEvent = false}) {
    return _$initialStateAsyncAction
        .run(() => super.initialState(isNewEvent: isNewEvent));
  }

  late final _$changePageStateAsyncAction =
      AsyncAction('_CalendarController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$deleteEventAsyncAction =
      AsyncAction('_CalendarController.deleteEvent', context: context);

  @override
  Future<void> deleteEvent(String id) {
    return _$deleteEventAsyncAction.run(() => super.deleteEvent(id));
  }

  late final _$loadEventAsyncAction =
      AsyncAction('_CalendarController.loadEvent', context: context);

  @override
  Future<void> loadEvent(EventModel event) {
    return _$loadEventAsyncAction.run(() => super.loadEvent(event));
  }

  late final _$_getEventsAsyncAction =
      AsyncAction('_CalendarController._getEvents', context: context);

  @override
  Future<void> _getEvents() {
    return _$_getEventsAsyncAction.run(() => super._getEvents());
  }

  late final _$searchPatientAsyncAction =
      AsyncAction('_CalendarController.searchPatient', context: context);

  @override
  Future<void> searchPatient(String fullname) {
    return _$searchPatientAsyncAction.run(() => super.searchPatient(fullname));
  }

  late final _$changePatientAsyncAction =
      AsyncAction('_CalendarController.changePatient', context: context);

  @override
  Future<void> changePatient(PatientModel patient) {
    return _$changePatientAsyncAction.run(() => super.changePatient(patient));
  }

  late final _$_CalendarControllerActionController =
      ActionController(name: '_CalendarController', context: context);

  @override
  void changeCalendarFormat(CalendarFormat format) {
    final _$actionInfo = _$_CalendarControllerActionController.startAction(
        name: '_CalendarController.changeCalendarFormat');
    try {
      return super.changeCalendarFormat(format);
    } finally {
      _$_CalendarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getEventsForDay(DateTime day) {
    final _$actionInfo = _$_CalendarControllerActionController.startAction(
        name: '_CalendarController.getEventsForDay');
    try {
      return super.getEventsForDay(day);
    } finally {
      _$_CalendarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<EventModel> loadEventsPerDay(DateTime day) {
    final _$actionInfo = _$_CalendarControllerActionController.startAction(
        name: '_CalendarController.loadEventsPerDay');
    try {
      return super.loadEventsPerDay(day);
    } finally {
      _$_CalendarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final _$actionInfo = _$_CalendarControllerActionController.startAction(
        name: '_CalendarController.onDaySelected');
    try {
      return super.onDaySelected(selectedDay, focusedDay);
    } finally {
      _$_CalendarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
calendarFormat: ${calendarFormat},
dateFocused: ${dateFocused},
dateSelected: ${dateSelected},
pageState: ${pageState},
errorMessage: ${errorMessage},
formText: ${formText},
selectedEvents: ${selectedEvents}
    ''';
  }
}
