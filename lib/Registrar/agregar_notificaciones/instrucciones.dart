import 'package:flutter/material.dart';

class Instrucciones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Para agregar Contactos, favor de seguir las siguientes instrucciones:",
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
              Text("\u2022 Presionar el símbolo \"+\" e ingresar el nombre y numero de contacto.",
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
        Text("Los contactos registrados también serán usados para mandar avisos en caso de que queden pocas pastillas en los compartimentos o estén a punto de caducarse.",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}