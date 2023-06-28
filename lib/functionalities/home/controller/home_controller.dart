import 'package:mobx/mobx.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  _HomeController({required this.firebaseRepository});

  final FirebaseRepository firebaseRepository;

  bool isUserLogged() {
    return firebaseRepository.userIsLoggedIn();
  }
}
