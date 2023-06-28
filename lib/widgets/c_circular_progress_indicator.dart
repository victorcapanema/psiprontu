import 'package:flutter/material.dart';
import 'package:prontuario/shared/colors/app_colors.dart';

class CCircularProgressIndicator extends StatelessWidget {
  const CCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(
          color: AppColors.forest,
        ),
      ),
    );
  }
}
