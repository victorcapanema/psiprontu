import 'package:flutter/services.dart';
import 'package:prontuario/shared/constants/extensions.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.convertToTitleCase(),
      selection: newValue.selection,
    );
  }
}

