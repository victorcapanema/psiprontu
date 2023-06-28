import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CDeleteAlertDialog extends StatelessWidget {
  const CDeleteAlertDialog({this.functionDelete, required this.id, Key? key}) : super(key: key);
  final void Function(String)? functionDelete;
  final String id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ATENÇÃO!'),
      content: RichText(
          text: const TextSpan(children: [
        TextSpan(text: 'Deseja realmente '),
        TextSpan(text: 'EXCLUIR ', style: TextStyle(color: Colors.red)),
        TextSpan(text: 'o registro?')
      ])),
      actions: <Widget>[
        TextButton(
          onPressed: () => Modular.to.pop(),
          child: const Text('Não'),
        ),
        TextButton(
          onPressed: () => {functionDelete!(id), Modular.to.pop()},
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
