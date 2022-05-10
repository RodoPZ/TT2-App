import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Registrar/agregar_seguridad/camera.dart';

class ReconocimientoFacial extends StatefulWidget{

  @override
  State<ReconocimientoFacial> createState() => _ReconocimientoFacialState();
}

class _ReconocimientoFacialState extends State<ReconocimientoFacial> {

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
            ButtonMain(buttonText: "Iniciar reconocimiento", icono: Icons.camera_alt , callback: () async{
              final cameras =await availableCameras();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (builder) => CameraApp(cameras: cameras)),
              );
            })
          ],

        ),
      ),
    );
  }
}