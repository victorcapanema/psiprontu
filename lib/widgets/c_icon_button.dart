import 'package:flutter/material.dart';
import '../shared/colors/app_colors.dart';

class CIconButton extends StatefulWidget {
  const CIconButton(
      {Key? key,
      required this.icon,
      required this.tooltipText,
      this.onPressed,
      this.size,
      this.padding,
      this.color = AppColors.forest,
      this.hoverColor = AppColors.marine})
      : super(key: key);
  final Widget icon;
  final String tooltipText;
  final void Function()? onPressed;
  final double? size;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? hoverColor;

  @override
  State<CIconButton> createState() => _CIconButtonState();
}

class _CIconButtonState extends State<CIconButton> {
  bool _isHovered = false;
  final FocusNode _iconFocus = FocusNode();

  @override
  void initState() {
    _iconFocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _iconFocus.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltipText,
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _iconFocus.hasFocus ? widget.color?.withOpacity(0.2) : Colors.transparent),
            child: IconButton(
                padding: widget.padding,
                focusNode: _iconFocus,
                icon: widget.icon,
                iconSize: widget.size,
                color: _isHovered ? widget.hoverColor : widget.color,
                onPressed: widget.onPressed),
          )),
    );
  }
}
