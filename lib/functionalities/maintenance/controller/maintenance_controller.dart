import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:prontuario/models/appointment_model.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';
import 'dart:async';

part 'maintenance_controller.g.dart';

class MaintenanceController = _MaintenanceController with _$MaintenanceController;

abstract class _MaintenanceController with Store {
  final TextEditingController nameFilterController = TextEditingController();
  final TextEditingController surnameFilterController = TextEditingController();
  final TextEditingController dateAppointmentController = TextEditingController();
  final FirebaseRepository firebaseRepository;

  List<String> entities = ['Paciente', 'Consulta'];
  List<String>? listPatientId = [];

  @observable
  List<bool> listArrows = [true, true, true];

  _MaintenanceController({required this.firebaseRepository});

  @observable
  String errorMessage = '';

  @observable
  PageState pageState = PageState.success;

  @observable
  late String dropdownValue = entities.first;

  @observable
  List<PatientModel> listPatients = [];

  @observable
  List<AppointmentModel> listAppointments = [];

  @observable
  bool isUpwardPatient = true;

  @observable
  bool isUpwardAppointment = true;

  @observable
  bool isUpwardAppointmentPatient = true;

  void initialState() {
    changeDropDownValue('Paciente');
    getListPatients();
  }

  bool isUserLogged() {
    return firebaseRepository.userIsLoggedIn();
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> changeDropDownValue(String value) async {
    dropdownValue = value;
  }

  @action
  Future<void> getListPatients() async {
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseGetAllPatients()).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {listPatients = r, sortList(arrowUp: true), changePageState(PageState.success)});
  }

  @action
  Future<void> getListPatientsFiltered({String name = '', String surname = ''}) async {
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseGetAllPatients(filterName: name, filterSurname: surname)).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {listPatients = r, changePageState(PageState.success)});
  }

  @action
  Future<void> getListAppointmentsFiltered({String? dateAppointment, String name = '', String surname = ''}) async {
    changePageState(PageState.loading);
    listPatientId = [];
    if (name != '' || surname != '') {
      await getListPatientsFiltered(name: name, surname: surname);
      for (var item in listPatients) {
        listPatientId?.add(item.idPatient!);
      }
    } else {
      listPatientId = null;
    }

    (await firebaseRepository.firebaseGetAllAppointments(
            dateAppointment: dateAppointment != null && dateAppointmentController.text.isNotEmpty
                ? DateFormat.yMd('pt_BR').parse(dateAppointmentController.text)
                : null,
            listPatientId: listPatientId))
        .fold((l) => {changePageState(PageState.error), errorMessage = l},
            (r) => {listAppointments = r, changePageState(PageState.success)});
  }

  @action
  Future<void> getListAppointments() async {
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseGetAllAppointments()).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {listAppointments = r, sortList(arrowUp: true), changePageState(PageState.success)});
  }

  @action
  Future<void> deleteRegister(String id) async {
    changePageState(PageState.loading);
    switch (dropdownValue) {
      case 'Paciente':
        (await firebaseRepository.firebaseDeletePatient(id)).fold(
            (l) => {changePageState(PageState.error), errorMessage = l},
            (r) => {changePageState(PageState.success), getListPatients()});
        break;
      case 'Consulta':
        (await firebaseRepository.firebaseDeleteAppointment(id)).fold(
            (l) => {changePageState(PageState.error), errorMessage = l},
            (r) => {changePageState(PageState.success), getListAppointments()});
        break;
    }
  }

  @action
  Future<void> resetGrid() async {
    nameFilterController.text = '';
    surnameFilterController.text = '';
    dateAppointmentController.text = '';
    switch (dropdownValue) {
      case 'Paciente':
        await getListPatients();
        break;
      case 'Consulta':
        await getListAppointments();
        break;
    }
  }

  @action
  Future<void> changeArrowPatient() async {
    isUpwardPatient = !isUpwardPatient;
  }

  @action
  Future<void> changeArrowAppointment() async {
    isUpwardAppointment = !isUpwardAppointment;
  }

  @action
  Future<void> changeArrowAppointmentPatient() async {
    isUpwardAppointmentPatient = !isUpwardAppointmentPatient;
  }

  @action
  Future<void> sortList({bool arrowUp = false, bool isOrderPatient = false}) async {
    switch (dropdownValue) {
      case 'Paciente':
        arrowUp ? null : await changeArrowPatient();
        isUpwardPatient
            ? listPatients.sort((a, b) => a.name.compareTo(b.name))
            : listPatients.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Consulta':
        if (isOrderPatient) {
          arrowUp ? null : await changeArrowAppointmentPatient();
          isUpwardAppointmentPatient
              ? listAppointments.sort((a, b) => a.patient!.name.compareTo(b.patient!.name))
              : listAppointments.sort((a, b) => b.patient!.name.compareTo(a.patient!.name));
        } else {
          arrowUp ? null : await changeArrowAppointment();
          isUpwardAppointment
              ? listAppointments.sort((a, b) => a.dateAppointment!.compareTo(b.dateAppointment!))
              : listAppointments.sort((a, b) => b.dateAppointment!.compareTo(a.dateAppointment!));
        }
        break;
    }
    listArrows = [isUpwardPatient, isUpwardAppointment, isUpwardAppointmentPatient];
  }

  bool isError() => pageState == PageState.error ? true : false;
  bool isLoading() => pageState == PageState.loading ? true : false;
  bool isPatientFilter() => dropdownValue == 'Paciente' ? true : false;
  bool isAppointmentFilter() => dropdownValue == 'Consulta' ? true : false;
}
