import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:prontuario/models/responsible_model.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';

part 'patient_controller.g.dart';

class PatientController = _PatientController with _$PatientController;

abstract class _PatientController with Store {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController dateBornController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cidController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController medicationController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();

  final TextEditingController resNameController = TextEditingController();
  final TextEditingController resSurnameController = TextEditingController();
  final TextEditingController resCpfController = TextEditingController();
  final TextEditingController resPhoneController = TextEditingController();

  final FirebaseRepository firebaseRepository;
  late PatientModel _patient;
  late ResponsibleModel _responsible;

  int indexResponsible = 0;
  bool isResEdit = false;
  String idResponsibleEdit = '';
  String patientId = '';
  String titleText = '';

  _PatientController({required this.firebaseRepository});

  @observable
  PageState pageState = PageState.success;

  @observable
  PageMode pageMode = PageMode.ins;

  @observable
  bool isChecked = false;

  @observable
  bool isExpanded = true;

  @observable
  String errorMessage = '';

  @observable
  ObservableList<ResponsibleModel> responsibles = ObservableList<ResponsibleModel>.of([]);

  ObservableList<ResponsibleModel> auxResponsibles = ObservableList<ResponsibleModel>.of([]);

  bool isUserLogged() {
    return firebaseRepository.userIsLoggedIn();
  }

  @action
  Future<void> initialPageState(String id, String mode) async {
    clearForm();
    patientId = id;
    switch (mode) {
      case 'upd':
        isExpanded = true;
        titleText = 'Editar Paciente';
        changePageMode(PageMode.upd);
        _getPatient(patientId);
        break;
      case 'dsp':
        titleText = 'Visualizar Paciente';
        changePageMode(PageMode.dsp);
        isChecked = false;
        isExpanded = false;
        _getPatient(patientId);
        break;
      default:
        titleText = 'Cadastrar Paciente';
        changePageMode(PageMode.ins);
        break;
    }
  }

  @action
  Future<void> changePageMode(PageMode state) async {
    pageMode = state;
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  @action
  Future<void> changeCheckState(bool value) async {
    isChecked = value;
    isChecked ? isExpanded = true : false;
  }

  @action
  Future<void> changeExpandedState() async {
    isExpanded = !isExpanded;
  }

  @action
  Future<void> _reloadPage() async {
    clearForm();
    _getPatient(patientId);
  }

  Future<void> persistPatient() async {
    changePageState(PageState.loading);
    _patient = PatientModel(
        name: nameController.text,
        surname: surnameController.text,
        cid: cidController.text,
        cpf: cpfController.text,
        dateBorn: DateFormat.yMd('pt_BR').parse(dateBornController.text),
        dateStart: DateFormat.yMd('pt_BR').parse(dateStartController.text),
        dateEnd: dateEndController.text != '' ? DateFormat.yMd('pt_BR').parse(dateEndController.text) : null,
        address: addressController.text,
        haveResponsible: isChecked,
        idPatient: patientId,
        phone: phoneController.text,
        medication: medicationController.text,
        complaint: complaintController.text);

    if (pageMode == PageMode.upd) {
      (await firebaseRepository.firebaseUpdatePatient(_patient, responsibles)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l}, (r) => {changePageState(PageState.success)});
    } else {
      (await firebaseRepository.firebaseInsertPatient(_patient, responsibles)).fold(
          (l) => {changePageState(PageState.error), errorMessage = l}, (r) => {changePageState(PageState.success)});
    }

    if (PageState.success == PageState.success) {
      pageMode == PageMode.upd ? _reloadPage() : clearForm();
    }
  }

  @action
  Future<void> _getPatient(String id) async {
    changePageState(PageState.loading);
    (await firebaseRepository.firebaseGetPatient(id)).fold(
        (l) => {changePageState(PageState.error), errorMessage = l},
        (r) => {
              nameController.text = r.name,
              surnameController.text = r.surname,
              cpfController.text = r.cpf,
              cidController.text = r.cid,
              dateBornController.text = r.dateBorn == null ? '' : DateFormat('dd/MM/yyyy').format(r.dateBorn!),
              dateStartController.text = r.dateStart == null ? '' : DateFormat('dd/MM/yyyy').format(r.dateStart!),
              dateEndController.text = r.dateEnd == null ? '' : DateFormat('dd/MM/yyyy').format(r.dateEnd!),
              addressController.text = r.address,
              isChecked = r.haveResponsible,
              phoneController.text = r.phone,
              medicationController.text = r.medication,
              complaintController.text = r.complaint,
              if (r.listResponsibles != null)
                {
                  for (var item in r.listResponsibles!) {responsibles.add(item)}
                },
              responsibles.sort((a, b) => a.name.compareTo(b.name)),
              changePageState(PageState.success)
            });
  }

  @action
  Future<void> deleteResponsible(int index) async {
    responsibles.removeAt(index);
  }

  @action
  Future<void> unMarkDeleteResponsible(int index) async {
    responsibles[index].isDelete = false;
    auxResponsibles = ObservableList<ResponsibleModel>.of(responsibles.reversed.toList());
    responsibles = ObservableList<ResponsibleModel>.of(auxResponsibles.reversed.toList());
  }

  @action
  Future<void> markDeleteResponsible(int index) async {
    if (pageMode == PageMode.upd) {
      responsibles[index].isDelete = true;
      responsibles[index].isEdit = false;
    } else {
      responsibles.removeAt(index);
    }
    auxResponsibles = ObservableList<ResponsibleModel>.of(responsibles.reversed.toList());
    responsibles = ObservableList<ResponsibleModel>.of(auxResponsibles.reversed.toList());
  }

  @action
  Future<void> updateResponsible() async {
    if (isResEdit) {
      for (var item in responsibles) {
        if (item.idResponsible == idResponsibleEdit) {
          item.isEdit = true;
          auxResponsibles = ObservableList<ResponsibleModel>.of(responsibles.reversed.toList());
          responsibles = ObservableList<ResponsibleModel>.of(auxResponsibles.reversed.toList());
        }
      }
    } else {
      _responsible = ResponsibleModel(
          name: resNameController.text,
          surname: resSurnameController.text,
          cpf: resCpfController.text,
          phone: resPhoneController.text);
      responsibles.add(_responsible);
    }
    clearResForm();
  }

  @action
  Future<void> loadResponsible(int i) async {
    resNameController.text = responsibles[i].name;
    resSurnameController.text = responsibles[i].surname;
    resCpfController.text = responsibles[i].cpf;
    resPhoneController.text = responsibles[i].phone;
    isResEdit = true;
    indexResponsible = i;
    isExpanded = true;
    idResponsibleEdit = responsibles[i].idResponsible;
  }

  @action
  Future<void> clearForm() async {
    nameController.text = '';
    surnameController.text = '';
    cpfController.text = '';
    cidController.text = '';
    dateBornController.text = '';
    dateStartController.text = '';
    dateEndController.text = '';
    addressController.text = '';
    phoneController.text = '';
    medicationController.text = '';
    complaintController.text = '';
    isChecked = false;
    responsibles.clear();
    clearResForm();
  }

  @action
  Future<void> clearResForm() async {
    resNameController.text = '';
    resSurnameController.text = '';
    resCpfController.text = '';
    resPhoneController.text = '';
    isResEdit = false;
    indexResponsible = 0;
  }

  bool isFieldEnabled() => pageState == PageState.loading || pageMode == PageMode.dsp ? false : true;

  bool isFieldVisible() => pageMode == PageMode.dsp ? false : true;

  bool isError() => pageState == PageState.error ? true : false;

  bool isLoading() => pageState == PageState.loading ? true : false;
}
