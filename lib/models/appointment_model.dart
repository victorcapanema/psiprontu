import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prontuario/models/patient_model.dart';

class AppointmentModel {
  final DateTime? dateAppointment;
  final String? idPatient;
  final String? idAppointment;
  final String dataAppointment;
  late PatientModel? patient;

  AppointmentModel(
      {required this.dateAppointment, this.idAppointment, this.idPatient, this.dataAppointment = '', this.patient});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
        idPatient: json['id_patient'] ?? '',
        idAppointment: json['id_appointment'] ?? '',
        dateAppointment: (json['date_appointment'] as Timestamp).toDate(),
        dataAppointment: json['data_appointment'] ?? '');
  }

  @override
  String toString() {
    return 'idAppointment: $idAppointment, idPatient: $idPatient, dataAppointment: $dataAppointment, patient: $patient,';
  }
}
