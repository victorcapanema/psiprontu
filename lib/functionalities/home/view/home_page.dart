import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:prontuario/widgets/c_app_bar.dart';
import 'package:prontuario/widgets/c_menu_tile.dart';

import '../../../widgets/c_bottom_bar.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Modular.get<HomeController>();

  @override
  void initState() {
    !homeController.isUserLogged() ? Modular.to.pushReplacementNamed(Modular.initialRoute) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CBottomBar(),
        appBar: CAppBar(isHome: true),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CMenuTile(
                        icon: Icons.assignment_add,
                        onTap: () {
                          Modular.to.pushNamed('/appointmentPage?id=' '&mode=ins');
                        },
                        title: 'Nova Consulta',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CMenuTile(
                        icon: Icons.person_add,
                        onTap: () {
                          Modular.to.pushNamed('/patitentPage?id=' '&mode=ins');
                        },
                        title: 'Cadastrar Paciente',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CMenuTile(
                        icon: Icons.edit_document,
                        onTap: () {
                          Modular.to.pushNamed('/maintenancePage');
                        },
                        title: 'Visualisar Dados',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CMenuTile(
                        icon: Icons.calendar_month_outlined,
                        onTap: () {
                          Modular.to.pushNamed('/calendarPage');
                        },
                        title: 'Agendar Consulta',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
