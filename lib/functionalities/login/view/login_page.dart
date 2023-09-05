import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/shared/colors/app_colors.dart';
import 'package:prontuario/shared/constants/validator.dart';
import 'package:prontuario/widgets/c_circular_progress_indicator.dart';
import 'package:prontuario/widgets/c_elevated_button.dart';
import 'package:prontuario/widgets/c_text_form_field.dart';
import '../../../shared/web_libs/htlm_functions.dart';
import '../../../widgets/c_icon_button.dart';
import '../../../widgets/contacts.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = Modular.get<LoginController>();

  @override
  void initState() {
    if (!loginController.isUserLogged()) {
      Modular.to.pushReplacementNamed('/homepage');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.forest,
      body: Observer(
        builder: (_) => SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/dataBG.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 400),
                    width: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width / 10),
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('BEM-VINDO AO SITE',
                                style: TextStyle(color: Colors.black, fontSize: 25, shadows: [
                                  Shadow(color: Colors.white, offset: Offset(5, 5), blurRadius: 15),
                                ])),
                            const SizedBox(height: 8),
                            const Text(
                              'Este é um sistema de prontuário para psicólogos, aqui você pode cadastrar pacientes, agendar e realizar consultas, imprimir a evolução e mais... ',
                              style: TextStyle(color: Colors.black, fontSize: 20, shadows: [
                                Shadow(color: Colors.white, offset: Offset(5, 5), blurRadius: 15),
                              ]),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 20, shadows: [
                                    Shadow(color: Colors.white, offset: Offset(5, 5), blurRadius: 15),
                                  ]),
                                  text: 'O projeto foi feito utilizando Flutter, mais informações acesse o github '),
                              WidgetSpan(
                                child: CIconButton(
                                    onPressed: () {
                                      openNewTab('https://github.com/victorcapanema/psiprontu');
                                    },
                                    icon: Image.asset('images/github.png'),
                                    tooltipText: 'GitHub: victorcapanema'),
                              ),
                              const TextSpan(text: '.')
                            ])),
                            const SizedBox(height: 30),
                            const Text(
                              'CONTATOS',
                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Contacts(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 40, 0, 0),
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 400),
                    decoration: const BoxDecoration(color: Colors.white),
                    width: (MediaQuery.of(context).size.width / 2) - 100,
                    child: Form(
                      key: loginController.formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: loginController.errorMessage != '',
                                child: Text(
                                    style: const TextStyle(fontSize: 30, color: Colors.red),
                                    loginController.errorMessage)),
                            SizedBox(height: MediaQuery.of(context).size.height / 6),
                            const Text('Login', style: TextStyle(color: AppColors.forest, fontSize: 50)),
                            const SizedBox(height: 60),
                            CTextFormField(
                              isEnabled: loginController.isFieldEnabled(),
                              text: 'Usuário',
                              controller: loginController.userController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validator.validateEmail,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            CTextFormField(
                              text: 'Senha',
                              isEnabled: loginController.isFieldEnabled(),
                              controller: loginController.pwController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              validator: Validator.validatePassword,
                              obscureText: loginController.isHiddenPassword,
                              suffixIcon: Focus(
                                descendantsAreFocusable: false,
                                canRequestFocus: false,
                                child: CIconButton(
                                  tooltipText: 'Senha visível',
                                  icon: Icon(
                                    loginController.isHiddenPassword ? Icons.visibility_off : Icons.visibility,
                                  ),
                                  onPressed: loginController.changePasswordVisibility,
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            CheckboxListTile(
                                enabled: loginController.isFieldEnabled(),
                                title: const Text('Lembrar me'),
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: AppColors.forest,
                                visualDensity: VisualDensity.compact,
                                value: loginController.isRemember,
                                shape: customOutlineInputBorder(Colors.black),
                                onChanged: (value) {
                                  loginController.changeCheckState(value!);
                                }),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            loginController.isFieldEnabled()
                                ? CElevatedButton(
                                    height: 25,
                                    text: 'Entrar',
                                    function: () {
                                      if (loginController.isValidated) {
                                        loginController.login();
                                      }
                                    },
                                  )
                                : const CCircularProgressIndicator(),
                            SizedBox(height: MediaQuery.of(context).size.height / 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
