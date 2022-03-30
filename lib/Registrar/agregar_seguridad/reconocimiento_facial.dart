import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';

class ReconocimientoFacial extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Text("Para agregar su rostro y poder reconocerlo, favor de seguir las siguientes instrucciones",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("\u2022 Presionar el botón \"Iniciar reconocimiento\"",
                      style: TextStyle(
                        fontSize: 17,
                      )
                  ),
                  Text("\u2022 Seguir las instrucciones en pantalla",
                      style: TextStyle(
                        fontSize: 17,
                      )
                  ),
                  Text("\u2022 Presionar el botón de \"Registrar\"",                                    style: TextStyle(
                    fontSize: 17,
                  )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ButtonMain(buttonText: "Iniciar reconocimiento", icono: Icons.camera_alt , callback: (){})
          ],

        ),
      ),
    );
  }
}