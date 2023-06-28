import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/functionalities/home/view/home_page.dart';
import 'package:prontuario/functionalities/patient/view/patient_page.dart';
import 'package:prontuario/functionalities/patient_popup/view/patient_popup_page.dart';
import 'package:prontuario/functionalities/prints/view/patient_evolution_page.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'functionalities/appointment/controller/appointment_controller.dart';
import 'functionalities/appointment/view/appointment_page.dart';
import 'functionalities/calendar/controller/calendar_controller.dart';
import 'functionalities/calendar/view/calendar_page.dart';
import 'functionalities/home/controller/home_controller.dart';
import 'functionalities/login/controller/login_controller.dart';
import 'functionalities/login/view/login_page.dart';
import 'functionalities/maintenance/controller/maintenance_controller.dart';
import 'functionalities/maintenance/view/maintence_page.dart';
import 'functionalities/patient/controller/patient_controller.dart';
import 'functionalities/patient_popup/controller/patient_popup_controller.dart';
import 'functionalities/prints/controller/patient_evolution_controller.dart';

///Configures the app dependencies and routes
///
///Modular https://pub.dev/packages/flutter_modular is used to achieve it
///All page controllers are singleton and injected with the same firebaseRepository instance
///As the application has a small size, there is only one module and all routes are defined here
class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => LoginController(firebaseRepository: i.get())),
        Bind.singleton((i) => HomeController(firebaseRepository: i.get())),
        Bind.singleton((i) => PatientController(firebaseRepository: i.get())),
        Bind.singleton((i) => MaintenanceController(firebaseRepository: i.get())),
        Bind.singleton((i) => AppointmentController(firebaseRepository: i.get())),
        Bind.singleton((i) => PatientPopupController(firebaseRepository: i.get())),
        Bind.singleton((i) => CalendarController(firebaseRepository: i.get())),
        Bind.singleton((i) => PatientEvolutionController(firebaseRepository: i.get())),
        Bind.singleton((i) => FirebaseRepository()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (context, args) => const LoginPage()),
        ChildRoute('/homepage', child: (context, args) => const HomePage()),
        ChildRoute('/maintenancePage', child: (context, args) => const MaintenancePage()),
        ChildRoute('/calendarPage', child: (context, args) => const CalendarPage()),
        ChildRoute('/patientEvolutionPage',
            child: (context, args) => PatientEvolutionPage(patientId: args.queryParams['patientId'])),
        ChildRoute('/patitentPage',
            child: (context, args) => PatientPage(id: args.queryParams['id'], mode: args.queryParams['mode'])),
        ChildRoute('/patitentPopupPage',
            child: (context, args) => PatientPopupPage(fullname: args.queryParams['fullname'])),
        ChildRoute('/appointmentPage',
            child: (context, args) => AppointmentPage(
                id: args.queryParams['id'], mode: args.queryParams['mode'], patientId: args.queryParams['patientId'])),
      ];
}
