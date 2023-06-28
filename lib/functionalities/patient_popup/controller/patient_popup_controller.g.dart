// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_popup_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatientPopupController on _PatientPopupController, Store {
  late final _$errorMessageAtom =
      Atom(name: '_PatientPopupController.errorMessage', context: context);

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
      Atom(name: '_PatientPopupController.pageState', context: context);

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

  late final _$listPatientsAtom =
      Atom(name: '_PatientPopupController.listPatients', context: context);

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

  late final _$isUpwardPatientAtom =
      Atom(name: '_PatientPopupController.isUpwardPatient', context: context);

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

  late final _$changePageStateAsyncAction =
      AsyncAction('_PatientPopupController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$getListPatientsAsyncAction =
      AsyncAction('_PatientPopupController.getListPatients', context: context);

  @override
  Future<void> getListPatients() {
    return _$getListPatientsAsyncAction.run(() => super.getListPatients());
  }

  late final _$getListPatientsFilteredAsyncAction = AsyncAction(
      '_PatientPopupController.getListPatientsFiltered',
      context: context);

  @override
  Future<void> getListPatientsFiltered({String name = ''}) {
    return _$getListPatientsFilteredAsyncAction
        .run(() => super.getListPatientsFiltered(name: name));
  }

  late final _$sortListAsyncAction =
      AsyncAction('_PatientPopupController.sortList', context: context);

  @override
  Future<void> sortList({bool arrowUp = false}) {
    return _$sortListAsyncAction.run(() => super.sortList(arrowUp: arrowUp));
  }

  late final _$changeArrowPatientAsyncAction = AsyncAction(
      '_PatientPopupController.changeArrowPatient',
      context: context);

  @override
  Future<void> changeArrowPatient() {
    return _$changeArrowPatientAsyncAction
        .run(() => super.changeArrowPatient());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
pageState: ${pageState},
listPatients: ${listPatients},
isUpwardPatient: ${isUpwardPatient}
    ''';
  }
}
