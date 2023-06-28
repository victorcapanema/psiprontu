import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../shared/colors/app_colors.dart';

class CDrawer extends StatelessWidget {
  const CDrawer({this.actualPage = '', Key? key}) : super(key: key);
  final String actualPage;

  @override
  Widget build(BuildContext context) {

    void goToPage(String url) {
      Modular.to.pop(context);
      Modular.to.pushNamed(url);
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.marine),
            child: Center(
                child: Text(
              'Prontuário',
              style: TextStyle(fontSize: 30),
            )),
          ),
          ListTile(
            title: const Text('PÁGINA INICIAL'),
            onTap: () {
              goToPage('/homepage');
            },
          ),
          Visibility(
            visible: actualPage != 'patient',
            child: ListTile(
              title: const Text('NOVO PACIENTE'),
              onTap: () {
                goToPage('/patitentPage?id=' '&mode=ins');
              },
            ),
          ),
          Visibility(
            visible: actualPage != 'appointment',
            child: ListTile(
              title: const Text('NOVA CONSULTA'),
              onTap: () {
                goToPage('/appointmentPage?id=' '&mode=ins');
              },
            ),
          ),
          Visibility(
            visible: actualPage != 'maintenance',
            child: ListTile(
              title: const Text('VISUALIZAR DADOS'),
              onTap: () {
                goToPage('/maintenancePage');
              },
            ),
          ),
          Visibility(
            visible: actualPage != 'calendar',
            child: ListTile(
              title: const Text('ANGENDA'),
              onTap: () {
                goToPage('/calendarPage');
              },
            ),
          ),
        ],
      ),
    );
  }
}
