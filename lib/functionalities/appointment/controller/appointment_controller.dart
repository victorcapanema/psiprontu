import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';
import 'package:prontuario/models/appointment_model.dart';

part 'appointment_controller.g.dart';

class AppointmentController = _AppointmentController with _$AppointmentController;

abstract class _AppointmentController with Store {
  _AppointmentController({required this.firebaseRepository});

  final TextEditingController dateAppointmentController = TextEditingController();
  final TextEditingController dataAppointmentController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController patientDateBornController = TextEditingController();
  final FirebaseRepository firebaseRepository;

  String idPatient = '';
  String idAppointment = '';
  String titleText = '';

  late AppointmentModel _appointment;
  late PatientModel _patient;

  List<PatientModel> listPatients = [];

  @observable
  PatientModel patient = PatientModel(
    name: '',
    surname: '',
    cpf: '',
    cid: '',
    address: '',
    dateBorn: null,
    dateStart: null,
    dateEnd: null,
  );

  @observable
  String errorMessage = '';

  @observable
  PageState pageState = PageState.success;

  @observable
  PageMode pageMode = PageMode.ins;

  bool isUserLogged() {
    return firebaseRepository.userIsLoggedIn();
  }

  Future<void> initialState(String id, String mode, String patientId) async {
    clearForm();
    idAppointment = id;
    switch (mode) {
      case 'upd':
        changePageMode(PageMode.upd);
        await _getAppointments(idAppointment);
        break;
      case 'dsp':
        changePageMode(PageMode.dsp);
        await _getAppointments(idAppointment);
        break;
      default:
        if (patientId.isNotEmpty) {
          await _getPatient(patientId);
        }
        changePageMode(PageMode.ins);
        break;
    }
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> changePageMode(PageMode state) async {
    pageMode = state;
    switch (state) {
      case PageMode.upd:
        titleText = 'Editar Consulta';
        break;
      case PageMode.dsp:
        titleText = 'Visualizar Consulta';
        break;
      default:
        titleText = 'Nova Consulta';
        idAppointment = '';
        break;
    }
  }

  @action
  Future<void> changePatient(PatientModel patient) async {
    _patient = patient;
    idPatient = _patient.idPatient!;
    patientNameController.text = _patient.fullname;
    patientDateBornController.text =
        _patient.dateBorn == null ? '' : DateFormat('dd/MM/yyyy').format(_patient.dateBorn!);
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
  Future<void> _getAppointments(String id) async {
    if (id.isNotEmpty) {
      changePageState(PageState.loading);
      (await firebaseRepository.firebaseGetAppointment(id)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {
                _appointment = AppointmentModel(
                    idAppointment: r.idAppointment,
                    idPatient: r.idPatient,
                    dateAppointment: r.dateAppointment,
                    dataAppointment: r.dataAppointment,
                    patient: r.patient),
                dataAppointmentController.text = _appointment.dataAppointment,
                dateAppointmentController.text = _appointment.dateAppointment == null
                    ? ''
                    : DateFormat('dd/MM/yyyy').format(_appointment.dateAppointment!),
                changePageState(PageState.success),
                changePatient(_appointment.patient!)
              });
    }
  }

  @action
  Future<void> _getPatient(String id) async {
    if (id.isNotEmpty) {
      changePageState(PageState.loading);
      (await firebaseRepository.firebaseGetPatient(id)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {
                patient = PatientModel(
                  idPatient: r.idPatient,
                  name: r.name,
                  surname: r.surname,
                  cpf: r.cpf,
                  cid: r.cid,
                  dateBorn: r.dateBorn!,
                  dateStart: r.dateStart,
                  dateEnd: r.dateEnd,
                  address: r.address,
                  haveResponsible: r.haveResponsible,
                  fullname: r.fullname,
                ),
                changePatient(patient),
                changePageState(PageState.success)
              });
    }
  }

  Future<void> persistAppointment({bool isParcial = false}) async {
    changePageState(PageState.loading);
    _appointment = AppointmentModel(
      idAppointment: idAppointment,
      idPatient: idPatient,
      dataAppointment: dataAppointmentController.text,
      dateAppointment: DateFormat.yMd('pt_BR').parse(dateAppointmentController.text),
      patient: null,
    );
    if (pageMode == PageMode.upd) {
      (await firebaseRepository.firebaseUpdateAppointment(_appointment)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {
                if (!isParcial) {clearForm(), changePageMode(PageMode.ins)},
                changePageState(PageState.success)
              });
    } else {
      (await firebaseRepository.firebaseInsertAppointment(_appointment)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l},
          (r) => {
                isParcial ? {idAppointment = r, changePageMode(PageMode.upd)} : clearForm(),
                changePageState(PageState.success)
              });
    }
  }

  @action
  Future<void> clearForm() async {
    dateAppointmentController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    dataAppointmentController.text = '';
    patientNameController.text = '';
    patientDateBornController.text = '';
    idPatient = '';
  }

  bool verifyPatient() {
    return patientNameController.text == patient.fullname;
  }

  String? validatePatient(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um paciente.';
    } else if (idPatient == '' || patientNameController.text != _patient.fullname) {
      return 'Paciente não encontrado.';
    }
    return null;
  }

  bool isFieldEnabled() => pageState == PageState.loading || pageMode == PageMode.dsp ? false : true;

  bool isFieldVisible() => pageMode == PageMode.dsp ? false : true;

  bool isError() => pageState == PageState.error ? true : false;

  bool isLoading() => pageState == PageState.loading ? true : false;
}
