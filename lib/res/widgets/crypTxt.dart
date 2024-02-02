import 'package:flutter/material.dart';

class CrypText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final bool hasPadding;
  final EdgeInsets padding;

  const CrypText({
    Key? key,
    this.text = "",
    this.style = const TextStyle(color: Colors.black),
    this.hasPadding = false,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasPadding
        ? Padding(
            padding: padding,
            child: Text(text, style: style),
          )
        : Text(text, style: style);
  }
}
