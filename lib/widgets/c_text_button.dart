import 'package:flutter/material.dart';

class WTextButton extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Function()? onTap;
  final bool isEnabled;

  const WTextButton(
      {required this.text,
        this.style,
        this.onTap,
        this.isEnabled = true,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Ink(
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
