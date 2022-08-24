import 'package:flutter/material.dart';

class Instrucciones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Para agregar pastillas, favor de seguir las siguientes instrucciones:",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Presionar el botón \"Abrir compartimientos\"",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Sacar el comportamiento",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Llenar el comportamiento con las pastillas deseadas",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Volver a poner el comportamiento en su lugar",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Presionar el símbolo \"+\" y elige el nombre, la cantidad y la caducidad de las pastillas.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text("\u2022 Presionar el botón \"Registrar\" para confirmar.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ],
    );
  }
}