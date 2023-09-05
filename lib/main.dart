import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_module.dart';
import 'package:flutter/gestures.dart';

///Initalizes the app
///
///Firebase is initialized here [main]
///In Widget build are defined the localization and scroll options utilized by calendar and vertical scroll when needed
///
///Use your own key right here
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC9xNHHSxlWuVmfaUpJNzXHBX-5P78RqHQ",
          authDomain: "prontuario-7614a.firebaseapp.com",
          projectId: "prontuario-7614a",
          storageBucket: "prontuario-7614a.appspot.com",
          messagingSenderId: "302055403564",
          appId: "1:302055403564:web:5293ac50a7a3317e4fa189",
          measurementId: "G-3NT7NLVXM6"));
  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Modular.to.addListener(() {
        if (FirebaseAuth.instance.currentUser == null && Modular.to.path != Modular.initialRoute) {
          Modular.to.pushReplacementNamed(Modular.initialRoute);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Modular.to.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      scrollBehavior: MyCustomScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
