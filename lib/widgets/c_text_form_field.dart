import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/colors/app_colors.dart';

class CTextFormField extends StatelessWidget {
  final String? text;
  final String? hintText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? errorText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final bool isEnabled;
  final EdgeInsets? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatter;

  const CTextFormField({
    Key? key,
    this.text,
    this.hintText,
    this.floatingLabelBehavior,
    this.errorText,
    this.validator,
    this.suffixIcon,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
    this.isEnabled = true,
    this.contentPadding,
    this.autovalidateMode,
    this.focusNode,
    this.autofocus= false,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.inputFormatter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      onTap: onTap,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      enabled: isEnabled,
      style: const TextStyle(color: Colors.black),
      validator: validator,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      minLines: minLines,
      maxLines: obscureText ? 1 : maxLines,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        labelText: text,
        hintText: hintText,
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding: contentPadding,
        errorText: errorText,
        errorMaxLines: 5,
        filled: !isEnabled,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: customOutlineInputBorder(Colors.black),
        disabledBorder: customOutlineInputBorder(AppColors.sleekGrey),
        focusedBorder: customOutlineInputBorder(Colors.black),
        errorBorder: customOutlineInputBorder(Colors.red),
        focusedErrorBorder: customOutlineInputBorder(Colors.red),
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

InputBorder? customOutlineInputBorder(Color borderColor) {
  return OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: borderColor),
      borderRadius: BorderRadius.circular(5));
}
