import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';

part 'patient_popup_controller.g.dart';

class PatientPopupController = _PatientPopupController with _$PatientPopupController;

abstract class _PatientPopupController with Store {
  _PatientPopupController({required this.firebaseRepository});

  final FirebaseRepository firebaseRepository;
  final TextEditingController patientNameController = TextEditingController();

  @observable
  String errorMessage = '';

  @observable
  PageState pageState = PageState.success;

  @observable
  List<PatientModel> listPatients = [];

  @observable
  bool isUpwardPatient = true;

  void initialState(String fullname) {
    if(fullname != ''){
      patientNameController.text = fullname;
      getListPatientsFiltered(name: fullname);
    }else {
      getListPatients();
    }
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> getListPatients() async {
    changePageState(PageState.loading);
    patientNameController.text = '';
    (await firebaseRepository.firebaseGetAllPatients()).fold(
        (l) => {
              changePageState(PageState.error),
              errorMessage = l,
            },
        (r) => {listPatients = r, sortList(arrowUp: true), changePageState(PageState.success)});
  }

  @action
  Future<void> getListPatientsFiltered({String name = ''}) async {
    changePageState(PageState.loading);
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseGetAllPatients(filterFullname: name)).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {listPatients = r, sortList(arrowUp: true), changePageState(PageState.success)});
  }

  @action
  Future<void> sortList({
    bool arrowUp = false,
  }) async {
    arrowUp ? null : await changeArrowPatient();
    isUpwardPatient
        ? listPatients.sort((a, b) => a.name.compareTo(b.name))
        : listPatients.sort((a, b) => b.name.compareTo(a.name));
  }

  @action
  Future<void> changeArrowPatient() async {
    isUpwardPatient = !isUpwardPatient;
  }

  bool isError() => pageState == PageState.error ? true : false;

  bool isLoading() => pageState == PageState.loading ? true : false;

  bool isSuccess() => pageState == PageState.success ? true : false;
}
