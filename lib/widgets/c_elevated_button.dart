import 'package:flutter/material.dart';
import 'package:prontuario/shared/colors/app_colors.dart';

class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    required this.text,
    this.function,
    this.isEnabled = true,
    this.width = double.infinity,
    this.height = 16,
    this.tooltipText = '',
    Key? key,
  }) : super(key: key);
  final String text;
  final VoidCallback? function;
  final bool isEnabled;
  final double width;
  final double height;
  final String tooltipText;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipText,
      waitDuration: const Duration(milliseconds: 500),
      child: ElevatedButton(
        onPressed: isEnabled ? function : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forest,
          minimumSize: Size(width, 20),
          padding: EdgeInsets.symmetric(vertical: height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(text),
      ),
    );
  }
}
