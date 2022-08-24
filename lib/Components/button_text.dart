import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget{

  String buttonText = "Text here";
  Color buttonColor;
  double textSize = 20;
  VoidCallback callback;

  ButtonText(this.buttonText, this.buttonColor, this.textSize, this.callback,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: buttonColor,
        textStyle: TextStyle(
            fontSize: textSize),
      ),
      onPressed: callback,
      child: Text(buttonText),
    );
  }
}