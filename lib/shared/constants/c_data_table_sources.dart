import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:prontuario/models/appointment_model.dart';
import '../../models/patient_model.dart';
import '../../widgets/c_delete_alert_dialog.dart';
import '../../widgets/c_icon_button.dart';
import '../colors/app_colors.dart';
import '../web_libs/htlm_functions.dart';
import 'entities.dart';

class PatientSource extends DataTableSource {
  List<PatientModel> listPatients;
  MenuOptions? selectedMenu;
  bool isView;
  BuildContext context;
  void Function(String)? functionDelete;

  PatientSource({required this.listPatients, required this.context, this.isView = false, this.functionDelete});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listPatients.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        isView
            ? Container(
                decoration: BoxDecoration(color: AppColors.forest.withOpacity(0.7), shape: BoxShape.circle),
                child: CIconButton(
                    color: Colors.white,
                    tooltipText: 'Selecionar paciente',
                    onPressed: () {
                      Modular.to.pop(listPatients[index]);
                    },
                    icon: const Icon(Icons.check)),
              )
            : PopupMenuButton<MenuOptions>(
                initialValue: selectedMenu,
                onSelected: (MenuOptions item) {
                  switch (item) {
                    case MenuOptions.upd:
                      Modular.to.pushNamed('/patitentPage?id=${listPatients[index].idPatient}&mode=upd');
                      break;
                    case MenuOptions.dsp:
                      Modular.to.pushNamed('/patitentPage?id=${listPatients[index].idPatient}&mode=dsp');
                      break;
                    case MenuOptions.del:
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              CDeleteAlertDialog(id: listPatients[index].idPatient!, functionDelete: functionDelete));
                      break;
                    case MenuOptions.print:
                      openNewTab(
                          'https://prontuario-7614a.web.app/#/patientEvolutionPage?patientId=${listPatients[index].idPatient}');
                      // openNewTab('http://localhost:50930/#/patientEvolutionPage?patientId=${listPatients[index].idPatient}');
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => menuList(isPatient: true)),
      ),
      DataCell(Text('${listPatients[index].name} ${listPatients[index].surname}')),
      DataCell(Text(listPatients[index].cpf)),
      DataCell(Text(listPatients[index].cid)),
    ]);
  }
}

class AppointmentSource extends DataTableSource {
  List<AppointmentModel> listAppointments;
  MenuOptions? selectedMenu;
  bool isView;
  BuildContext context;
  void Function(String)? functionDelete;

  AppointmentSource({required this.listAppointments, required this.context, this.isView = false, this.functionDelete});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listAppointments.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        isView
            ? IconButton(
                onPressed: () {
                  Modular.to.pop(listAppointments[index].idAppointment);
                },
                icon: const Icon(Icons.check))
            : PopupMenuButton<MenuOptions>(
                initialValue: selectedMenu,
                onSelected: (MenuOptions item) {
                  switch (item) {
                    case MenuOptions.upd:
                      Modular.to.pushNamed('/appointmentPage?id=${listAppointments[index].idAppointment}&mode=upd');
                      break;
                    case MenuOptions.dsp:
                      Modular.to.pushNamed('/appointmentPage?id=${listAppointments[index].idAppointment}&mode=dsp');
                      break;
                    case MenuOptions.del:
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => CDeleteAlertDialog(
                              id: listAppointments[index].idAppointment!, functionDelete: functionDelete));
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => menuList()),
      ),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(listAppointments[index].dateAppointment!))),
      DataCell(Text('${listAppointments[index].patient?.name} ${listAppointments[index].patient?.surname}')),
    ]);
  }
}

List<PopupMenuEntry<MenuOptions>> menuList({bool isPatient = false}) {
  return <PopupMenuEntry<MenuOptions>>[
    const PopupMenuItem<MenuOptions>(
      value: MenuOptions.dsp,
      child: Text('Visualizar'),
    ),
    const PopupMenuItem<MenuOptions>(
      value: MenuOptions.upd,
      child: Text('Editar'),
    ),
    const PopupMenuItem<MenuOptions>(
      value: MenuOptions.del,
      child: Text('Excluir'),
    ),
    if (isPatient)
      const PopupMenuItem<MenuOptions>(
        value: MenuOptions.print,
        child: Text('Imprimir'),
      ),
  ];
}
