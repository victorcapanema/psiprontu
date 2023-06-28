import 'package:mobx/mobx.dart';
import 'package:prontuario/models/patient_model.dart';
import 'package:prontuario/models/appointment_model.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/constants/entities.dart';

part 'patient_evolution_controller.g.dart';

class PatientEvolutionController = _PatientEvolutionController with _$PatientEvolutionController;

abstract class _PatientEvolutionController with Store {
  _PatientEvolutionController({required this.firebaseRepository});

  final FirebaseRepository firebaseRepository;

  late PatientModel patient;

  List<AppointmentModel> listAppointments = [];
  List<String>? listPatientId = [];
  String errorMessage = '';

  @observable
  PageState pageState = PageState.success;

  Future<void> initialState(String patientId) async {
    changePageState(PageState.loading);
    await _getPatient(patientId);
    !isError() ? await getListAppointmentsByPatient() : null;
    !isError() ? changePageState(PageState.success) : null;
  }

  @action
  Future<void> getListAppointmentsByPatient() async {
    listPatientId?.add(patient.idPatient!);
    (await firebaseRepository.firebaseGetAllAppointments(listPatientId: listPatientId)).fold(
        (l) => {errorMessage = l, changePageState(PageState.error)},
        (r) =>
            {listAppointments = r, listAppointments.sort((a, b) => a.dateAppointment!.compareTo(b.dateAppointment!))});
  }

  @action
  Future<void> _getPatient(String id) async {
    (await firebaseRepository.firebaseGetPatient(id))
        .fold((l) => {errorMessage = l, changePageState(PageState.error)}, (r) => {patient = r});
  }

  @action
  Future<void> changePageState(PageState state) async {
    pageState = state;
  }

  bool isError() => pageState == PageState.error ? true : false;
  bool isLoading() => pageState == PageState.loading ? true : false;
  bool isSuccess() => pageState == PageState.success ? true : false;
}
