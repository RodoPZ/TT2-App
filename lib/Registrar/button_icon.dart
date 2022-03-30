import 'package:flutter/material.dart';


class ButtonIcon extends StatelessWidget{
  late IconData icono;
  late String buttonText;
  VoidCallback callback;
  ButtonIcon(this.icono, this.buttonText, this.callback, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 140,
      child: OutlinedButton(
        onPressed: callback,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            Text(buttonText,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}