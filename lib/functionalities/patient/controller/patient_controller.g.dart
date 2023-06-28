// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PatientController on _PatientController, Store {
  late final _$pageStateAtom =
      Atom(name: '_PatientController.pageState', context: context);

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
      Atom(name: '_PatientController.pageMode', context: context);

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

  late final _$isCheckedAtom =
      Atom(name: '_PatientController.isChecked', context: context);

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  late final _$isExpandedAtom =
      Atom(name: '_PatientController.isExpanded', context: context);

  @override
  bool get isExpanded {
    _$isExpandedAtom.reportRead();
    return super.isExpanded;
  }

  @override
  set isExpanded(bool value) {
    _$isExpandedAtom.reportWrite(value, super.isExpanded, () {
      super.isExpanded = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PatientController.errorMessage', context: context);

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

  late final _$responsiblesAtom =
      Atom(name: '_PatientController.responsibles', context: context);

  @override
  ObservableList<ResponsibleModel> get responsibles {
    _$responsiblesAtom.reportRead();
    return super.responsibles;
  }

  @override
  set responsibles(ObservableList<ResponsibleModel> value) {
    _$responsiblesAtom.reportWrite(value, super.responsibles, () {
      super.responsibles = value;
    });
  }

  late final _$initialPageStateAsyncAction =
      AsyncAction('_PatientController.initialPageState', context: context);

  @override
  Future<void> initialPageState(String id, String mode) {
    return _$initialPageStateAsyncAction
        .run(() => super.initialPageState(id, mode));
  }

  late final _$changePageModeAsyncAction =
      AsyncAction('_PatientController.changePageMode', context: context);

  @override
  Future<void> changePageMode(PageMode state) {
    return _$changePageModeAsyncAction.run(() => super.changePageMode(state));
  }

  late final _$changePageStateAsyncAction =
      AsyncAction('_PatientController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$changeCheckStateAsyncAction =
      AsyncAction('_PatientController.changeCheckState', context: context);

  @override
  Future<void> changeCheckState(bool value) {
    return _$changeCheckStateAsyncAction
        .run(() => super.changeCheckState(value));
  }

  late final _$changeExpandedStateAsyncAction =
      AsyncAction('_PatientController.changeExpandedState', context: context);

  @override
  Future<void> changeExpandedState() {
    return _$changeExpandedStateAsyncAction
        .run(() => super.changeExpandedState());
  }

  late final _$_reloadPageAsyncAction =
      AsyncAction('_PatientController._reloadPage', context: context);

  @override
  Future<void> _reloadPage() {
    return _$_reloadPageAsyncAction.run(() => super._reloadPage());
  }

  late final _$_getPatientAsyncAction =
      AsyncAction('_PatientController._getPatient', context: context);

  @override
  Future<void> _getPatient(String id) {
    return _$_getPatientAsyncAction.run(() => super._getPatient(id));
  }

  late final _$deleteResponsibleAsyncAction =
      AsyncAction('_PatientController.deleteResponsible', context: context);

  @override
  Future<void> deleteResponsible(int index) {
    return _$deleteResponsibleAsyncAction
        .run(() => super.deleteResponsible(index));
  }

  late final _$unMarkDeleteResponsibleAsyncAction = AsyncAction(
      '_PatientController.unMarkDeleteResponsible',
      context: context);

  @override
  Future<void> unMarkDeleteResponsible(int index) {
    return _$unMarkDeleteResponsibleAsyncAction
        .run(() => super.unMarkDeleteResponsible(index));
  }

  late final _$markDeleteResponsibleAsyncAction =
      AsyncAction('_PatientController.markDeleteResponsible', context: context);

  @override
  Future<void> markDeleteResponsible(int index) {
    return _$markDeleteResponsibleAsyncAction
        .run(() => super.markDeleteResponsible(index));
  }

  late final _$updateResponsibleAsyncAction =
      AsyncAction('_PatientController.updateResponsible', context: context);

  @override
  Future<void> updateResponsible() {
    return _$updateResponsibleAsyncAction.run(() => super.updateResponsible());
  }

  late final _$loadResponsibleAsyncAction =
      AsyncAction('_PatientController.loadResponsible', context: context);

  @override
  Future<void> loadResponsible(int i) {
    return _$loadResponsibleAsyncAction.run(() => super.loadResponsible(i));
  }

  late final _$clearFormAsyncAction =
      AsyncAction('_PatientController.clearForm', context: context);

  @override
  Future<void> clearForm() {
    return _$clearFormAsyncAction.run(() => super.clearForm());
  }

  late final _$clearResFormAsyncAction =
      AsyncAction('_PatientController.clearResForm', context: context);

  @override
  Future<void> clearResForm() {
    return _$clearResFormAsyncAction.run(() => super.clearResForm());
  }

  @override
  String toString() {
    return '''
pageState: ${pageState},
pageMode: ${pageMode},
isChecked: ${isChecked},
isExpanded: ${isExpanded},
errorMessage: ${errorMessage},
responsibles: ${responsibles}
    ''';
  }
}
