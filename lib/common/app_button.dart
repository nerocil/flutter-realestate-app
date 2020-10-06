import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color splashColor;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String fontFamily;
  final double radius;
  final Alignment alignment;
  final double textFontSize;
  final EdgeInsets padding;

  const AppButton({
    Key key,
    @required this.onTap,
    this.splashColor,
    @required this.text,
    this.backgroundColor,
    this.fontFamily,
    this.textColor,
    this.alignment,
    this.padding,
    this.radius,
    this.textFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 5),
        child: InkWell(
          splashColor: splashColor ?? Colors.grey,
          borderRadius: BorderRadius.circular(radius ?? 5),
          onTap: () async => onTap(),
          child: Container(
            color: backgroundColor != null
                ? backgroundColor.withOpacity(0.8)
                : Colors.transparent,
            child: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.blue,
                  fontFamily: fontFamily ?? "regular",
                  fontSize: textFontSize ?? 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}