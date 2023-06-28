import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/appointment_model.dart';
import '../../models/event_model.dart';
import '../../models/patient_model.dart';
import '../../models/responsible_model.dart';
import '../../models/user_model.dart';

class FirebaseRepository {
  late CollectionReference appointmentsCollection;
  late CollectionReference patientsCollection;
  late CollectionReference responsiblesCollection;
  late CollectionReference eventsCollection;

  FirebaseRepository() {
    initializeFirebase();
  }

  void initializeFirebase() {
    patientsCollection = FirebaseFirestore.instance.collection('pacientes');
    appointmentsCollection = FirebaseFirestore.instance.collection('consultas');
    responsiblesCollection = FirebaseFirestore.instance.collection('responsaveis');
    eventsCollection = FirebaseFirestore.instance.collection('eventos');
  }

  Future<Either<String, void>> firebaseAuth(UserModel user, {bool isPersist = false}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.user, password: user.password);
      isPersist
          ? FirebaseAuth.instance.setPersistence(Persistence.LOCAL)
          : FirebaseAuth.instance.setPersistence(Persistence.SESSION);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  bool userIsLoggedIn() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<String, void>> firebaseLogOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseInsertPatient(
      PatientModel patient, List<ResponsibleModel> listResponsible) async {
    try {
      await patientsCollection.add({
        'name': patient.name,
        'surname': patient.surname,
        'fullname': '${patient.name} ${patient.surname}',
        'cpf': patient.cpf,
        'cid': patient.cid,
        'address': patient.address,
        'date_born': patient.dateBorn,
        'data_start_treatment': patient.dateStart,
        'data_end_treatment': patient.dateEnd,
        'have_responsible': patient.haveResponsible,
        'phone': patient.phone,
        'medication': patient.medication,
        'complaint': patient.complaint,
        'id_user': FirebaseAuth.instance.currentUser?.uid.length,
      }).then((docRef) => {
            docRef.update({'id_patient': docRef.id}),
            if (listResponsible.isNotEmpty)
              {
                for (var item in listResponsible)
                  {
                    responsiblesCollection.add({
                      'id_patient': docRef.id,
                      'name': item.name,
                      'surname': item.surname,
                      'cpf': item.cpf,
                      'phone': item.phone
                    }).then((docResRef) => {
                          docResRef.update({'id_responsible': docResRef.id}),
                        })
                  }
              }
          });

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, String>> firebaseInsertAppointment(AppointmentModel appointment) async {
    String idDoc = '';
    try {
      await appointmentsCollection.add({
        'date_appointment': appointment.dateAppointment,
        'id_patient': appointment.idPatient,
        'data_appointment': appointment.dataAppointment,
        'id_user': FirebaseAuth.instance.currentUser?.uid
      }).then((docRef) => {
            idDoc = docRef.id,
            docRef.update({'id_appointment': docRef.id}),
          });

      return Right(idDoc);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseInsertEvent(EventModel event) async {
    try {
      await eventsCollection.add({
        'date_event': event.date,
        'id_patient': event.idPatient,
        'info': event.info,
        'id_user': FirebaseAuth.instance.currentUser?.uid
      }).then((docRef) => {
            docRef.update({'id_event': docRef.id}),
          });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseUpdateEvent(EventModel event) async {
    try {
      final docAppointment = eventsCollection.doc(event.idEvent);
      await docAppointment.update({
        'date_event': event.date,
        'id_patient': event.idPatient,
        'info': event.info,
      });
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseUpdateAppointment(AppointmentModel appointment) async {
    try {
      final docAppointment = appointmentsCollection.doc(appointment.idAppointment);
      await docAppointment.update({
        'date_appointment': appointment.dateAppointment,
        'id_patient': appointment.idPatient,
        'data_appointment': appointment.dataAppointment,
      });

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseDeletePatient(String idPatient) async {
    try {
      final docPatient = patientsCollection.doc(idPatient);
      QuerySnapshot querySnapshot2 = await responsiblesCollection.where("id_patient", isEqualTo: idPatient).get();
      for (var e in querySnapshot2.docs) {
        e.reference.delete();
      }
      await docPatient.delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseDeleteAppointment(String idAppointment) async {
    try {
      final docAppointment = appointmentsCollection.doc(idAppointment);
      await docAppointment.delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseDeleteEvent(String idEvent) async {
    try {
      final docAppointment = eventsCollection.doc(idEvent);
      await docAppointment.delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, void>> firebaseUpdatePatient(
      PatientModel patient, List<ResponsibleModel> listResponsible) async {
    try {
      final docPatient = patientsCollection.doc(patient.idPatient);
      var docResponsible;
      await docPatient.update({
        'name': patient.name,
        'surname': patient.surname,
        'fullname': '${patient.name} ${patient.surname}',
        'cpf': patient.cpf,
        'cid': patient.cid,
        'address': patient.address,
        'date_born': patient.dateBorn,
        'data_start_treatment': patient.dateStart,
        'data_end_treatment': patient.dateEnd,
        'have_responsible': patient.haveResponsible,
        'phone': patient.phone,
        'medication': patient.medication,
        'complaint': patient.complaint
      }).then((e) => {
            for (var item in listResponsible)
              {
                if (item.idResponsible.isNotEmpty)
                  {
                    docResponsible = responsiblesCollection.doc(item.idResponsible),
                    if (item.isEdit)
                      {
                        docResponsible.update({
                          'name': item.name,
                          'surname': item.surname,
                          'cpf': item.cpf,
                          'phone': item.phone,
                        })
                      },
                    if (item.isDelete) {docResponsible.delete()}
                  }
                else
                  {
                    responsiblesCollection.add({
                      'id_patient': patient.idPatient,
                      'name': item.name,
                      'surname': item.surname,
                      'cpf': item.cpf,
                      'phone': item.phone
                    }).then((docResRef) => {
                          docResRef.update({'id_responsible': docResRef.id}),
                        })
                  }
              }
          });

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, PatientModel>> firebaseGetPatient(String id) async {
    try {
      QuerySnapshot querySnapshot = await patientsCollection.where("id_patient", isEqualTo: id).get();
      PatientModel? patient;
      if (querySnapshot.docs.isNotEmpty) {
        patient = PatientModel.fromJson(cast((querySnapshot.docs.map((doc) => doc.data()).toList().first)));
        QuerySnapshot querySnapshot2 = await responsiblesCollection.where("id_patient", isEqualTo: id).get();
        List<ResponsibleModel> listResponsibles = [];
        (querySnapshot2.docs.map((doc) => doc.data()).toList().forEach((e) {
          listResponsibles.add(ResponsibleModel.fromJson(cast(e)));
        }));
        patient.listResponsibles = listResponsibles;
        return Right(patient);
      } else {
        return const Left('Paciente não encontrado.');
      }
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, AppointmentModel>> firebaseGetAppointment(String id) async {
    try {
      QuerySnapshot querySnapshot = await appointmentsCollection.where("id_appointment", isEqualTo: id).get();
      AppointmentModel? appointment;
      if (querySnapshot.docs.isNotEmpty) {
        appointment = AppointmentModel.fromJson(cast((querySnapshot.docs.map((doc) => doc.data()).toList().first)));
        QuerySnapshot querySnapshot2 =
            await patientsCollection.where("id_patient", isEqualTo: appointment.idPatient).get();
        PatientModel? patient;
        if (querySnapshot2.docs.isNotEmpty) {
          patient = PatientModel.fromJson(cast((querySnapshot2.docs.map((doc) => doc.data()).toList().first)));
        }
        appointment.patient = patient;
        return Right(appointment);
      } else {
        return const Left('Consulta não encontrada.');
      }
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, List<EventModel>>> firebaseGetAllEvents() async {
    try {
      QuerySnapshot querySnapshot =
          await eventsCollection.where("id_user", isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        List<EventModel> listEvents = [];
        (querySnapshot.docs.map((doc) => doc.data()).toList().forEach((e) {
          listEvents.add(EventModel.fromJson(cast(e)));
        }));
        for (var item in listEvents) {
          QuerySnapshot querySnapshot2 = await patientsCollection.where("id_patient", isEqualTo: item.idPatient).get();
          PatientModel? patient;
          if (querySnapshot2.docs.isNotEmpty) {
            patient = PatientModel.fromJson(cast((querySnapshot2.docs.map((doc) => doc.data()).toList().first)));
          }
          item.patient = patient;
        }
        return Right(listEvents);
      } else {
        return const Left('Não foi possível carregar os eventos.');
      }
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, List<PatientModel>>> firebaseGetAllPatients(
      {String filterName = '', String filterSurname = '', String filterFullname = ''}) async {
    try {
      late QuerySnapshot querySnapshot;
      late QuerySnapshot querySnapshot2;
      if (filterFullname != '') {
        querySnapshot = await patientsCollection
            .where('fullname', isGreaterThanOrEqualTo: filterFullname)
            .where('fullname', isLessThan: '${filterFullname}z')
            .get();
      } else if (filterName != '' && filterSurname != '') {
        querySnapshot = await patientsCollection
            .where('name', isGreaterThanOrEqualTo: filterName)
            .where('name', isLessThan: '${filterName}z')
            .get();
        querySnapshot2 = await patientsCollection
            .where('surname', isGreaterThanOrEqualTo: filterSurname)
            .where('surname', isLessThan: '${filterSurname}z')
            .get();
      } else if (filterName != '') {
        querySnapshot = await patientsCollection
            .where('name', isGreaterThanOrEqualTo: filterName)
            .where('name', isLessThan: '${filterName}z')
            .get();
      } else if (filterSurname != '') {
        querySnapshot = await patientsCollection
            .where('surname', isGreaterThanOrEqualTo: filterSurname)
            .where('surname', isLessThan: '${filterSurname}z')
            .get();
      } else {
        querySnapshot = await patientsCollection.get();
      }
      List<PatientModel> listPatient = [];
      (querySnapshot.docs.map((doc) => doc.data()).toList().forEach((e) {
        listPatient.add(PatientModel.fromJson(cast(e)));
      }));

      if (filterName != '' && filterSurname != '') {
        List<PatientModel> listPatient2 = [];
        List<String> list2Ids = [];
        querySnapshot2.docs.map((doc) => doc.data()).toList().forEach((e) {
          listPatient2.add(PatientModel.fromJson(cast(e)));
        });
        for (var e in listPatient2) {
          list2Ids.add(e.idPatient!);
        }
        listPatient.removeWhere((e) => !list2Ids.contains(e.idPatient));
      }
      return Right(listPatient);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  Future<Either<String, List<AppointmentModel>>> firebaseGetAllAppointments(
      {DateTime? dateAppointment, List<String>? listPatientId}) async {
    try {
      late QuerySnapshot querySnapshot;
      if (dateAppointment != null && (listPatientId != null && listPatientId.isNotEmpty)) {
        querySnapshot = await appointmentsCollection
            .where('date_appointment', isEqualTo: dateAppointment)
            .where('id_patient', whereIn: listPatientId)
            .get();
      } else if (dateAppointment != null) {
        querySnapshot = await appointmentsCollection.where('date_appointment', isEqualTo: dateAppointment).get();
      } else if (listPatientId != null && listPatientId.isNotEmpty) {
        querySnapshot = await appointmentsCollection.where('id_patient', whereIn: listPatientId).get();
      } else {
        querySnapshot = await appointmentsCollection.get();
      }

      List<AppointmentModel> listAppointment = [];
      (querySnapshot.docs.map((doc) => doc.data()).toList().forEach((e) {
        listAppointment.add(AppointmentModel.fromJson(cast(e)));
      }));
      for (var item in listAppointment) {
        QuerySnapshot querySnapshot2 = await patientsCollection.where("id_patient", isEqualTo: item.idPatient).get();
        PatientModel? patient;
        if (querySnapshot2.docs.isNotEmpty) {
          patient = PatientModel.fromJson(cast((querySnapshot2.docs.map((doc) => doc.data()).toList().first)));
        }
        item.patient = patient;
      }
      return Right(listAppointment);
    } on FirebaseException catch (e) {
      return Left(errorTreatment(e.code));
    }
  }

  String errorTreatment(String e) {
    switch (e) {
      case 'permission-denied':
        return 'Sem permições para acesso.';
      case 'user-not-found':
        return 'Usuário ou senha incorretos.';
      case 'wrong-password':
        return 'Usuário ou senha incorretos.';
      case 'too-many-request':
        return 'Muitas requisições no momento, aguarde.';
      case 'not-found':
        return 'Registro não encontrado.';
      default:
        return 'Erro desconhecido.';
    }
  }
}
