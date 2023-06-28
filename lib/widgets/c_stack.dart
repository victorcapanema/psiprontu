import 'package:flutter/material.dart';

///Custom Stack
///
///Defines what is basicaly a highlighted container with a text on the upper edge
class CStack extends StatelessWidget {
  const CStack(
      {Key? key,
      required this.children,
      this.text = '',
      this.width = 800,
      this.height = 650,
      this.padding,
      this.margin,
      this.isPadding = false,
      this.isMargin = false,
      this.hideTitle = false})
      : super(key: key);
  final String text;
  final double? width;
  final double? height;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isPadding;
  final bool isMargin;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: width,
        margin: !isMargin ? const EdgeInsets.fromLTRB(20, 20, 20, 10) : margin,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: !isPadding ? const EdgeInsets.fromLTRB(40, 30, 40, 15) : padding!,
          child: Column(children: children),
        ),
      ),
      Visibility(
        visible: !hideTitle,
        child: Positioned(
          left: 60,
          top: 8,
          child: Container(
            color: Colors.white.withOpacity(0.4),
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
    ]);
  }
}
