// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MaintenanceController on _MaintenanceController, Store {
  late final _$listArrowsAtom =
      Atom(name: '_MaintenanceController.listArrows', context: context);

  @override
  List<bool> get listArrows {
    _$listArrowsAtom.reportRead();
    return super.listArrows;
  }

  @override
  set listArrows(List<bool> value) {
    _$listArrowsAtom.reportWrite(value, super.listArrows, () {
      super.listArrows = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MaintenanceController.errorMessage', context: context);

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

  late final _$pageStateAtom =
      Atom(name: '_MaintenanceController.pageState', context: context);

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

  late final _$dropdownValueAtom =
      Atom(name: '_MaintenanceController.dropdownValue', context: context);

  @override
  String get dropdownValue {
    _$dropdownValueAtom.reportRead();
    return super.dropdownValue;
  }

  @override
  set dropdownValue(String value) {
    _$dropdownValueAtom.reportWrite(value, super.dropdownValue, () {
      super.dropdownValue = value;
    });
  }

  late final _$listPatientsAtom =
      Atom(name: '_MaintenanceController.listPatients', context: context);

  @override
  List<PatientModel> get listPatients {
    _$listPatientsAtom.reportRead();
    return super.listPatients;
  }

  @override
  set listPatients(List<PatientModel> value) {
    _$listPatientsAtom.reportWrite(value, super.listPatients, () {
      super.listPatients = value;
    });
  }

  late final _$listAppointmentsAtom =
      Atom(name: '_MaintenanceController.listAppointments', context: context);

  @override
  List<AppointmentModel> get listAppointments {
    _$listAppointmentsAtom.reportRead();
    return super.listAppointments;
  }

  @override
  set listAppointments(List<AppointmentModel> value) {
    _$listAppointmentsAtom.reportWrite(value, super.listAppointments, () {
      super.listAppointments = value;
    });
  }

  late final _$isUpwardPatientAtom =
      Atom(name: '_MaintenanceController.isUpwardPatient', context: context);

  @override
  bool get isUpwardPatient {
    _$isUpwardPatientAtom.reportRead();
    return super.isUpwardPatient;
  }

  @override
  set isUpwardPatient(bool value) {
    _$isUpwardPatientAtom.reportWrite(value, super.isUpwardPatient, () {
      super.isUpwardPatient = value;
    });
  }

  late final _$isUpwardAppointmentAtom = Atom(
      name: '_MaintenanceController.isUpwardAppointment', context: context);

  @override
  bool get isUpwardAppointment {
    _$isUpwardAppointmentAtom.reportRead();
    return super.isUpwardAppointment;
  }

  @override
  set isUpwardAppointment(bool value) {
    _$isUpwardAppointmentAtom.reportWrite(value, super.isUpwardAppointment, () {
      super.isUpwardAppointment = value;
    });
  }

  late final _$isUpwardAppointmentPatientAtom = Atom(
      name: '_MaintenanceController.isUpwardAppointmentPatient',
      context: context);

  @override
  bool get isUpwardAppointmentPatient {
    _$isUpwardAppointmentPatientAtom.reportRead();
    return super.isUpwardAppointmentPatient;
  }

  @override
  set isUpwardAppointmentPatient(bool value) {
    _$isUpwardAppointmentPatientAtom
        .reportWrite(value, super.isUpwardAppointmentPatient, () {
      super.isUpwardAppointmentPatient = value;
    });
  }

  late final _$changePageStateAsyncAction =
      AsyncAction('_MaintenanceController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$changeDropDownValueAsyncAction = AsyncAction(
      '_MaintenanceController.changeDropDownValue',
      context: context);

  @override
  Future<void> changeDropDownValue(String value) {
    return _$changeDropDownValueAsyncAction
        .run(() => super.changeDropDownValue(value));
  }

  late final _$getListPatientsAsyncAction =
      AsyncAction('_MaintenanceController.getListPatients', context: context);

  @override
  Future<void> getListPatients() {
    return _$getListPatientsAsyncAction.run(() => super.getListPatients());
  }

  late final _$getListPatientsFilteredAsyncAction = AsyncAction(
      '_MaintenanceController.getListPatientsFiltered',
      context: context);

  @override
  Future<void> getListPatientsFiltered(
      {String name = '', String surname = ''}) {
    return _$getListPatientsFilteredAsyncAction
        .run(() => super.getListPatientsFiltered(name: name, surname: surname));
  }

  late final _$getListAppointmentsFilteredAsyncAction = AsyncAction(
      '_MaintenanceController.getListAppointmentsFiltered',
      context: context);

  @override
  Future<void> getListAppointmentsFiltered(
      {String? dateAppointment, String name = '', String surname = ''}) {
    return _$getListAppointmentsFilteredAsyncAction.run(() => super
        .getListAppointmentsFiltered(
            dateAppointment: dateAppointment, name: name, surname: surname));
  }

  late final _$getListAppointmentsAsyncAction = AsyncAction(
      '_MaintenanceController.getListAppointments',
      context: context);

  @override
  Future<void> getListAppointments() {
    return _$getListAppointmentsAsyncAction
        .run(() => super.getListAppointments());
  }

  late final _$deleteRegisterAsyncAction =
      AsyncAction('_MaintenanceController.deleteRegister', context: context);

  @override
  Future<void> deleteRegister(String id) {
    return _$deleteRegisterAsyncAction.run(() => super.deleteRegister(id));
  }

  late final _$resetGridAsyncAction =
      AsyncAction('_MaintenanceController.resetGrid', context: context);

  @override
  Future<void> resetGrid() {
    return _$resetGridAsyncAction.run(() => super.resetGrid());
  }

  late final _$changeArrowPatientAsyncAction = AsyncAction(
      '_MaintenanceController.changeArrowPatient',
      context: context);

  @override
  Future<void> changeArrowPatient() {
    return _$changeArrowPatientAsyncAction
        .run(() => super.changeArrowPatient());
  }

  late final _$changeArrowAppointmentAsyncAction = AsyncAction(
      '_MaintenanceController.changeArrowAppointment',
      context: context);

  @override
  Future<void> changeArrowAppointment() {
    return _$changeArrowAppointmentAsyncAction
        .run(() => super.changeArrowAppointment());
  }

  late final _$changeArrowAppointmentPatientAsyncAction = AsyncAction(
      '_MaintenanceController.changeArrowAppointmentPatient',
      context: context);

  @override
  Future<void> changeArrowAppointmentPatient() {
    return _$changeArrowAppointmentPatientAsyncAction
        .run(() => super.changeArrowAppointmentPatient());
  }

  late final _$sortListAsyncAction =
      AsyncAction('_MaintenanceController.sortList', context: context);

  @override
  Future<void> sortList({bool arrowUp = false, bool isOrderPatient = false}) {
    return _$sortListAsyncAction.run(
        () => super.sortList(arrowUp: arrowUp, isOrderPatient: isOrderPatient));
  }

  @override
  String toString() {
    return '''
listArrows: ${listArrows},
errorMessage: ${errorMessage},
pageState: ${pageState},
dropdownValue: ${dropdownValue},
listPatients: ${listPatients},
listAppointments: ${listAppointments},
isUpwardPatient: ${isUpwardPatient},
isUpwardAppointment: ${isUpwardAppointment},
isUpwardAppointmentPatient: ${isUpwardAppointmentPatient}
    ''';
  }
}
