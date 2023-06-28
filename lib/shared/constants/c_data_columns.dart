import 'package:flutter/material.dart';
import '../../widgets/c_icon_button.dart';

List<DataColumn> getDataColumns(String columns, List<bool> arrows, void Function({bool isOrderPatient})? sortList) {
  switch (columns) {
    case 'Paciente':
      return [
        const DataColumn(label: Text('')),
        DataColumn(
            label: Row(
          children: [
            const Text('Nome'),
            CIconButton(
                onPressed: sortList,
                icon: arrows[0] ? const Icon(Icons.arrow_upward) : const Icon(Icons.arrow_downward),
                tooltipText: arrows[0] ? 'Mudar para ordem decrescente' : 'Mudar para ordem crescente'),
          ],
        )),
        const DataColumn(label: Text('CPF')),
        const DataColumn(label: Text('CID')),
      ];
    case 'Consulta':
      return [
        const DataColumn(label: Text('')),
        DataColumn(
            label: Row(
          children: [
            const Text('Data da Consulta'),
            CIconButton(
                onPressed: sortList,
                icon: arrows[1] ? const Icon(Icons.arrow_upward) : const Icon(Icons.arrow_downward),
                tooltipText: arrows[1] ? 'Mudar para ordem decrescente' : 'Mudar para ordem crescente')
          ],
        )),
        DataColumn(
            label: Row(
          children: [
            const Text('Paciente'),
            CIconButton(
                onPressed: () {
                  sortList!(isOrderPatient: true);
                },
                icon: arrows[2] ? const Icon(Icons.arrow_upward) : const Icon(Icons.arrow_downward),
                tooltipText: arrows[2] ? 'Mudar para ordem decrescente' : 'Mudar para ordem crescente'),
          ],
        )),
      ];
    default:
      return const [
        DataColumn(label: Text('')),
        DataColumn(label: Text('Data da Consulta')),
        DataColumn(label: Text('Paciente')),
      ];
  }
}
