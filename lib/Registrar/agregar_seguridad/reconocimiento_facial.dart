import 'package:flutter/material.dart';
import 'package:tt2/Components/httpComunications.dart';
import 'package:tt2/Components/item_manager.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tt2/SaveRead.dart';
import '../../Components/input_text.dart';
import '../../models.dart';

class ReconocimientoFacial extends StatefulWidget {
  @override
  State<ReconocimientoFacial> createState() => _ReconocimientoFacialState();
}

class _ReconocimientoFacialState extends State<ReconocimientoFacial> {
  String _faceRName = "";
  String _response = "False";
  final _readWrite = SaveRead();
  bool valuefirst = false;
  final _http = HTTP();

  Widget onAndroid() {
    return const Text(
      "¡¡¡Solo pueden usar esta función usando la interfaz del dispensador!!!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget onWeb() {
    Widget _buildNombre() {
      return InputText(
        inputHintText: "Nombre del usuario",
        inputmax: 20,
        textSize: 16,
        myValidator: (value) {
          if (value == null || value.isEmpty) {
            return "Se necesita un nombre";
          }
          return null;
        },
        myOnSave: (String? value) {
          _faceRName = value!;
        },
      );
    }

    Widget _buildIsAdmin() {
      return StatefulBuilder(builder: (context, setState) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Theme.of(context).primaryColor,
          secondary:
          Icon(Icons.admin_panel_settings, color: Theme.of(context).primaryColor),
          title: const Text(
            'Es Administrador',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          value: valuefirst,
          onChanged: (bool? newValue) {
            setState(() => valuefirst = newValue!);
          },
        );
      }
      );
    }

    Widget formItems() {
      return Column(
        children: [
          _buildNombre(),
          _buildIsAdmin(),
        ],
      );
    }

    _registerFace() async {
      final newFace = FaceRecognition(
          faceRName: _faceRName,
          isAdmin: valuefirst,
      );
      await _readWrite.saveFace(newFace);
    }

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Para agregar su rostro y poder reconocerlo, favor de seguir las siguientes instrucciones",
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
                      )),
                  Text("\u2022 Seguir las instrucciones en pantalla",
                      style: TextStyle(
                        fontSize: 17,
                      )),
                  Text("\u2022 Presionar el botón de \"Registrar\"",
                      style: TextStyle(
                        fontSize: 17,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ItemManager(
                dataSubTitle: const ["nombre"],
                dataTitle: "nombre",
                callback: () async {
                  if (_faceRName != "") {
                    _response = await _http.registerFace(_faceRName);
                    if(_response == "True"){
                      await _registerFace();
                      const snackBar = SnackBar(
                        content: Text('Información de rostro guardado!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                      setState(() {
                        _faceRName = "";
                      });
                    }else{
                      const snackBar = SnackBar(
                        content: Text('Ya existe un modelo con ese rostro!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    }
                  }
                },
                getter: _readWrite.getFace,
                deleter: _readWrite.deleteFace,
                form_items: formItems,
                register: _registerFace,
                icono: Icons.nfc,
                title: "Reconocimiento Facial",
                formTitle: "Registrar Rostro",
                buttonText: "Registrar Rostro",
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if(kIsWeb) onWeb() else if(Platform.isAndroid) onAndroid(),
    ]);
  }
}
