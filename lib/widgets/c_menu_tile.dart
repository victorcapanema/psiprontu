import 'package:flutter/material.dart';
import 'package:prontuario/shared/colors/app_colors.dart';

class CMenuTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final IconData? icon;
  const CMenuTile({required this.title, this.onTap, this.icon = Icons.add, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Ink(
            decoration: BoxDecoration(
              color: AppColors.marine,
              borderRadius: BorderRadius.circular(15.0),
            ),
            width: 170,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
                 const SizedBox(height: 5),
                 Icon(icon, color: Colors.white, size: 45)
              ]),
            )));
  }
}
