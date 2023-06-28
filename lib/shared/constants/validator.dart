import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'formatters.dart';

class Validator {
  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp _dateRegExp = RegExp(
      r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{4})$");
  static final RegExp _hourRegExp = RegExp(r"^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$");
  static final RegExp _cpfRegExp = RegExp(r"^\d{3}\.\d{3}\.\d{3}\-\d{2}");
  static final RegExp _onlyNumbers = RegExp(r'[0-9]');

  static String? validateEmail(String? valueEmail) {
    if (valueEmail == null || valueEmail.isEmpty) {
      return 'Por favor, informe o usuário.';
    }
    if (!_emailRegExp.hasMatch(valueEmail) || valueEmail.contains(' ')) {
      return 'Por favor, digite um email válido.';
    }
    return null;
  }

  static String? validatePassword(String? valuePassword) {
    if (valuePassword == null || valuePassword.isEmpty) {
      return 'Por favor, informe a senha.';
    }
    return null;
  }

  static String? validateEmpty(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um valor.';
    }
    return null;
  }

  static String? validateDate(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um valor.';
    } else if (!_dateRegExp.hasMatch(valueString)) {
      return 'Por favor, informe uma data válida.';
    }
    return null;
  }

  static String? validateCpf(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um valor.';
    } else if (!_cpfRegExp.hasMatch(valueString)) {
      return 'Por favor, informe uma CPF válido.';
    }
    return null;
  }

  static String? validateDateOptional(String? valueString) {
    if (valueString != null && valueString.isNotEmpty && !_dateRegExp.hasMatch(valueString)) {
      return 'Por favor, informe uma data válida.';
    }
    return null;
  }

  static String? validateHour(String? valueString) {
    if (valueString == null || valueString.isEmpty) {
      return 'Por favor, informe um valor.';
    } else if (!_hourRegExp.hasMatch(valueString)) {
      return 'Por favor, informe uma hora válida.';
    }
    return null;
  }

  static List<TextInputFormatter> inputDateTime() {
    return <TextInputFormatter>[
      MaskTextInputFormatter(mask: '##/##/####', filter: {"#": _onlyNumbers}, type: MaskAutoCompletionType.lazy),
      LengthLimitingTextInputFormatter(10),
    ];
  }

  static List<TextInputFormatter> inputTime() {
    return <TextInputFormatter>[
      MaskTextInputFormatter(mask: '##:##', filter: {"#": _onlyNumbers}, type: MaskAutoCompletionType.lazy),
      LengthLimitingTextInputFormatter(5),
    ];
  }

  static List<TextInputFormatter> inputCPF() {
    return <TextInputFormatter>[
      MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": _onlyNumbers}, type: MaskAutoCompletionType.lazy),
      LengthLimitingTextInputFormatter(14),
    ];
  }

  static List<TextInputFormatter> inputCapitalWords() {
    return <TextInputFormatter>[UpperCaseTextFormatter()];
  }
}
