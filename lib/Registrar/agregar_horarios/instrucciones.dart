import 'package:flutter/material.dart';

class Instrucciones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Para agregar horarios, favor de seguir las siguientes instrucciones:",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("\u2022 Presionar el símbolo \"+\" y elegir la hora y los días que se repetirá la alarma.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text("\u2022 Presionar el botón \"Agregar\" para confirmar.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}