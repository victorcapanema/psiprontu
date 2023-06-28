import 'package:flutter/material.dart';
import '../shared/colors/app_colors.dart';
import 'contacts.dart';

class CBottomBar extends StatelessWidget {
  const CBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(color: AppColors.marine),
      child: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                Flexible(child: Text('© 2023 Victor Carvalho Capanema. Todos os direitos reservados.')),
                Contacts(),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
