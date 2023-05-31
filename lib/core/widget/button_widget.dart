import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback action;
  final Color backgroundColor;
  final Color textColor;
  final double marginWidth;
  final double width;
  final Widget? body;
  final double marginHeight;
  final Color boarderColor;

  const ButtonWidget(
      {Key? key,
      required this.textColor,
      required this.boarderColor,
      this.text,
      required this.marginHeight,
        this.body,
      required this.marginWidth,
      required this.action,
        required this.width,
      required this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: marginWidth, vertical: marginHeight),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: boarderColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      width: width,
      child: body??TextButton(
          onPressed: action,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text!,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          )),
    );
  }
}
