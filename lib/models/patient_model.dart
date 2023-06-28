import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prontuario/models/responsible_model.dart';

class PatientModel {
  final String? idPatient;
  final String name;
  final String surname;
  final String fullname;
  final String cid;
  final String cpf;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final DateTime? dateBorn;
  final String address;
  final bool haveResponsible;
  final String phone;
  final String medication;
  final String complaint;
  List<ResponsibleModel>? listResponsibles;

  PatientModel(
      {this.idPatient,
      required this.name,
      required this.surname,
      required this.cid,
      required this.cpf,
      required this.dateBorn,
      required this.dateStart,
      required this.dateEnd,
      this.address = '',
      this.haveResponsible = false,
      this.listResponsibles,
      this.phone = '',
      this.complaint ='',
      this.medication = '',
      this.fullname = ''});

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
        idPatient: json['id_patient'] ?? '',
        name: json['name'] ?? '',
        surname: json['surname'] ?? '',
        cid: json['cid'] ?? '',
        cpf: json['cpf'] ?? '',
        dateStart: (json['data_start_treatment'] as Timestamp).toDate(),
        dateEnd: json['data_end_treatment'] != null ? (json['data_end_treatment'] as Timestamp).toDate() : null,
        dateBorn: (json['date_born'] as Timestamp).toDate(),
        address: json['address'] ?? '',
        haveResponsible: json['have_responsible'] ?? false,
        phone: json['phone'] ?? '',
        complaint: json['complaint'] ?? '',
        medication: json['medication'] ?? '',
        fullname: json['fullname'] ?? '');
  }

  @override
  String toString() {
    return 'idPatient: $idPatient, name: $name, surname: $surname, fullname: $fullname';
  }
}
