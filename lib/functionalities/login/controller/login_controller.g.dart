// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginController, Store {
  late final _$isHiddenPasswordAtom =
      Atom(name: '_LoginController.isHiddenPassword', context: context);

  @override
  bool get isHiddenPassword {
    _$isHiddenPasswordAtom.reportRead();
    return super.isHiddenPassword;
  }

  @override
  set isHiddenPassword(bool value) {
    _$isHiddenPasswordAtom.reportWrite(value, super.isHiddenPassword, () {
      super.isHiddenPassword = value;
    });
  }

  late final _$isRememberAtom =
      Atom(name: '_LoginController.isRemember', context: context);

  @override
  bool get isRemember {
    _$isRememberAtom.reportRead();
    return super.isRemember;
  }

  @override
  set isRemember(bool value) {
    _$isRememberAtom.reportWrite(value, super.isRemember, () {
      super.isRemember = value;
    });
  }

  late final _$pageStateAtom =
      Atom(name: '_LoginController.pageState', context: context);

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
      Atom(name: '_LoginController.errorMessage', context: context);

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

  late final _$changePasswordVisibilityAsyncAction = AsyncAction(
      '_LoginController.changePasswordVisibility',
      context: context);

  @override
  Future<void> changePasswordVisibility() {
    return _$changePasswordVisibilityAsyncAction
        .run(() => super.changePasswordVisibility());
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginController.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$changePageStateAsyncAction =
      AsyncAction('_LoginController.changePageState', context: context);

  @override
  Future<void> changePageState(PageState state) {
    return _$changePageStateAsyncAction.run(() => super.changePageState(state));
  }

  late final _$changeCheckStateAsyncAction =
      AsyncAction('_LoginController.changeCheckState', context: context);

  @override
  Future<void> changeCheckState(bool value) {
    return _$changeCheckStateAsyncAction
        .run(() => super.changeCheckState(value));
  }

  late final _$_LoginControllerActionController =
      ActionController(name: '_LoginController', context: context);

  @override
  void errorTimer() {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
        name: '_LoginController.errorTimer');
    try {
      return super.errorTimer();
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isHiddenPassword: ${isHiddenPassword},
isRemember: ${isRemember},
pageState: ${pageState},
errorMessage: ${errorMessage}
    ''';
  }
}
