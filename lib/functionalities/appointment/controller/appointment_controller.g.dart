// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppointmentController on _AppointmentController, Store {
  late final _$patientAtom =
      Atom(name: '_AppointmentController.patient', context: context);

  @override
  PatientModel get patient {
    _$patientAtom.reportRead();
    return super.patient;
  }

  @override
  set patient(PatientModel value) {
    _$patientAtom.reportWrite(value, super.patient, () {
      super.patient = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AppointmentController.errorMessage', context: context);

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
      Atom(name: '_AppointmentController.pageState', context: context);

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

  late final _$pageModeAtom =
      Atom(name: '_AppointmentController.pageMode', context: context);

  @override
  PageMode get pageMode {
    _$pageModeAtom.reportRead();
    return super.pageMode;
  }

  @override
  set pageMode(PageMode value) {
    _$pageModeAtom.reportWrite(value, super.pageMode, () {
      super.pageMode = value;
    });
  }

  late final _$changePageStateAsyncAction =
      AsyncAction('_AppointmentController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$changePageModeAsyncAction =
      AsyncAction('_AppointmentController.changePageMode', context: context);

  @override
  Future<void> changePageMode(PageMode state) {
    return _$changePageModeAsyncAction.run(() => super.changePageMode(state));
  }

  late final _$changePatientAsyncAction =
      AsyncAction('_AppointmentController.changePatient', context: context);

  @override
  Future<void> changePatient(PatientModel patient) {
    return _$changePatientAsyncAction.run(() => super.changePatient(patient));
  }

  late final _$searchPatientAsyncAction =
      AsyncAction('_AppointmentController.searchPatient', context: context);

  @override
  Future<void> searchPatient(String fullname) {
    return _$searchPatientAsyncAction.run(() => super.searchPatient(fullname));
  }

  late final _$_getAppointmentsAsyncAction =
      AsyncAction('_AppointmentController._getAppointments', context: context);

  @override
  Future<void> _getAppointments(String id) {
    return _$_getAppointmentsAsyncAction.run(() => super._getAppointments(id));
  }

  late final _$_getPatientAsyncAction =
      AsyncAction('_AppointmentController._getPatient', context: context);

  @override
  Future<void> _getPatient(String id) {
    return _$_getPatientAsyncAction.run(() => super._getPatient(id));
  }

  late final _$clearFormAsyncAction =
      AsyncAction('_AppointmentController.clearForm', context: context);

  @override
  Future<void> clearForm() {
    return _$clearFormAsyncAction.run(() => super.clearForm());
  }

  @override
  String toString() {
    return '''
patient: ${patient},
errorMessage: ${errorMessage},
pageState: ${pageState},
pageMode: ${pageMode}
    ''';
  }
}
