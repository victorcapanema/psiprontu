import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prontuario/models/patient_model.dart';

class EventModel {
  EventModel({this.idEvent, this.idPatient, required this.date, required this.info});

  final String? idEvent;
  final DateTime date;
  final String info;
  final String? idPatient;
  late PatientModel? patient;

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        idPatient: json['id_patient'] ?? '',
        idEvent: json['id_event'] ?? '',
        date: (json['date_event'] as Timestamp).toDate(),
        info: json['info'] ?? '');
  }

  @override
  String toString() {
    return 'idPatient: $idPatient, date: $date, info: $info';
  }
}
