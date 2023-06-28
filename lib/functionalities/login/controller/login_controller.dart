import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:prontuario/models/user_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/shared/constants/entities.dart';

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final FirebaseRepository firebaseRepository;
  late UserModel _user;

  Timer? countdownTimer;

  _LoginController({
    required this.firebaseRepository
  });

  @observable
  bool isHiddenPassword = true;

  @observable
  bool isRemember = false;

  @observable
  PageState pageState = PageState.success;

  @observable
  String errorMessage = '';

  @action
  Future<void> changePasswordVisibility() async {
    isHiddenPassword = !isHiddenPassword;
  }

  bool isUserLogged() {
    return firebaseRepository.userIsLoggedIn();
  }

  @action
  Future<void> login() async {
    changePageState(PageState.loading);
    _user = UserModel(user: userController.text, password: pwController.text);
    (await firebaseRepository.firebaseAuth(_user,isPersist: isRemember)).fold((l) => {changePageState(PageState.error), errorMessage = l,
      errorTimer()
    },
        (r) => {changePageState(PageState.success), Modular.to.pushReplacementNamed('/homepage')});
  }

  @action
  void errorTimer(){
    countdownTimer = Timer.periodic(const Duration(milliseconds: 4000), (t) {
      errorMessage = '';
     countdownTimer?.cancel();
    });
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> changeCheckState(bool value) async {
    isRemember = value;
  }

  bool get isValidated => formKey.currentState!.validate();

  bool isFieldEnabled() => pageState == PageState.loading ? false : true;

  bool isError() => pageState == PageState.error ? false : true;
}
