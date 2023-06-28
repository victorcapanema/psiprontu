import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prontuario/shared/constants/extensions.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../colors/app_colors.dart';

Color tileColor(bool isEdit, bool isDelete) {
  if (isEdit) {
    return Colors.orange.withOpacity(0.3);
  }
  if (isDelete) {
    return Colors.red.withOpacity(0.3);
  }
  return AppColors.seashell;
}

Color tileCalendarColor(DateTime dateTime) {
  if (dateTime.compareTo(DateTime.now()) < 0) {
    return AppColors.sleekGrey;
  } else if (dateTime.isSameDate(DateTime.now())) {
    return AppColors.marine;
  } else {
    return AppColors.feather;
  }
}

Future<void Function()?> datePicker(TextEditingController controller, dynamic context) async {
  DateTime? date = DateTime(1900);
  date = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  controller.text = date != null ? DateFormat('dd/MM/yyyy').format(date) : '';
  return null;
}

void showSnackBar(BuildContext context, bool isSuccess, String message) {
  showTopSnackBar(
      animationDuration: const Duration(milliseconds: 500),
      displayDuration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(horizontal: 100),
      Overlay.of(context),
      isSuccess
          ? CustomSnackBar.success(
              message: message,
            )
          : CustomSnackBar.error(
              message: message,
            ));
}
