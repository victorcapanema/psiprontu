import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/repositories/firebase/firebase_repository.dart';
import 'package:prontuario/shared/colors/app_colors.dart';
import 'package:prontuario/widgets/c_icon_button.dart';
import '../shared/constants/functions.dart';

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  CAppBar({this.isLogin = false, this.title = 'Prontuario', this.isHome = false, Key? key}) : super(key: key);
  final bool isLogin;
  final String title;
  final bool isHome;

  @override
  Size get preferredSize => const Size(double.infinity, 55);
  final firebaseRepository = Modular.get<FirebaseRepository>();

  @override
  Widget build(BuildContext context) {
    String message = '';
    return AppBar(
        title: MouseRegion(
          cursor: isHome ? SystemMouseCursors.basic : SystemMouseCursors.click,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isHome,
                child: CIconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (Modular.to.canPop()) {
                        Modular.to.pop();
                      }
                    },
                    hoverColor: Colors.white,
                    color: Colors.white,
                    tooltipText: 'Voltar para a página anterior'),
              ),
              Flexible(
                child: GestureDetector(
                  onTap: isHome
                      ? null
                      : () {
                          Modular.to.navigate('/homepage');
                        },
                  child: Tooltip(
                    message: isHome ? '' : 'Voltar para página principal',
                    waitDuration: const Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          title,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: !isLogin,
                          child: Tooltip(
                              message: 'Logout',
                              waitDuration: const Duration(milliseconds: 500),
                              child: IconButton(
                                  onPressed: () async {
                                    (await firebaseRepository.firebaseLogOut()).fold(
                                        (l) => {message = l, showSnackBar(context, false, message)},
                                        (r) => {Modular.to.pushReplacementNamed(Modular.initialRoute)});
                                  },
                                  icon: const Icon(Icons.logout))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.marine);
  }
}
