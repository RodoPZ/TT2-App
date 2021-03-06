import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Registrar/agregar_pastillas/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/SaveRead.dart';
import 'package:tt2/Components/item_manager.dart';
import 'package:tt2/Components/httpComunications.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AgregarPastillasMain extends StatefulWidget {
  @override
  State<AgregarPastillasMain> createState() => _AgregarPastillasMainState();
}

class _AgregarPastillasMainState extends State<AgregarPastillasMain> {
  final _readWrite = SaveRead();
  final _http = HTTP();
  late List items = [];
  late List contenedoresList = [1,2,3,4,5,6,7,8,9,10];
  bool loaded = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late int _contenedor;
  late String _pastillaNombre = "";
  late int _pastillaCantidad;
  late String _pastillaCaducidad = "";

  Widget onAndroid() {
    return Column(
      children: const [
        SizedBox(height: 100),
        Text(
          "¡¡¡Solo pueden usar esta función usando la interfaz del dispensador!!!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget onWeb() {
    Widget _buildNombre() {
      return InputText(
        inputText: "Nombre:",
        inputHintText: "Nombre de pastillas",
        inputmax: 15,
        textSize: 16,
        myValidator: (value) {
          if (value == null || value.isEmpty) {
            return "Se necesita un nombre";
          }
          return null;
        },
        myOnSave: (String? value) {
          _pastillaNombre = value!;
        },
      );
    }

    Widget _buildCantidad() {
      return InputText(
        inputText: "Cantidad: ",
        inputHintText: "Cantidad de pastillas",
        inputType: TextInputType.number,
        textSize: 16,
        myValidator: (value) {
          if (value == null || value.isEmpty) {
            return "Se necesita una cantidad";
          } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
            return "Solo se aceptan numeros";
          } else if (int.parse(value) > 30) {
            return "Cantidad máxima: 30";
          }
          return null;
        },
        myOnSave: (String? value) {
          _pastillaCantidad = int.parse(value!);
        },
      );
    }

    Widget _buildCaducidad() {
      return InputText(
        inputText: "Caducidad: ",
        inputHintText: "dd/mm/aaaa",
        textSize: 16,
        myValidator: (value) {
          RegExp regExp = RegExp(
              r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)(\d{4})$');
          if (value == null || value.isEmpty) {
            return "Se necesita una fecha";
          } else {
            if (!regExp.hasMatch(value)) {
              return "fecha no valida dd/mm/aaaa";
            }
          }
          return null;
        },
        myOnSave: (String? value) {
          _pastillaCaducidad = value!;
        },
      );
    }




    Widget formItems() {
      return Column(
        children: [
          _buildNombre(),
          _buildCantidad(),
          _buildCaducidad(),
        ],
      );
    }

    _registerPastillas() async {
      final newPastilla = Pastilla(
          contenedor: _contenedor,
          pastillaNombre: _pastillaNombre,
          pastillaCantidad: _pastillaCantidad,
          pastillaCaducidad: _pastillaCaducidad);
      await _readWrite.savePastilla(newPastilla);
    }

    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        right: 20,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services,
                size: 80,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              const Text(
                "Pastillas",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )
            ],
          ),
          const Divider(thickness: 2),
          Instrucciones(),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              right: 50,
              left: 50,
              bottom: 10,
            ),
            width: double.infinity,
          ),
          ItemManager(
            buttonText: "Abrir compartimento y registrar",
            dataSubTitle: const ["caducidad", "cantidad"],
            dataTitle: "nombre",
            deleter: _readWrite.deleteAll,
            deleterName: "Pastillas",
            getter: _readWrite.getPastilla,
            formTitle: "Registrar pastillas",
            title: "Pastillas",
            icono: Icons.medication,
            form_items: formItems,
            register: _registerPastillas,
            callback: () async {
              items = await _readWrite.getPastilla();
              for (var value in items) {
                contenedoresList.remove(value["contenedor"]);
              }
              setState(() =>_contenedor = contenedoresList[0]);
              await _registerPastillas();
              const snackBar = SnackBar(
                content:
                Text('Información de pastillas guardada!'),
              );
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar);
              Navigator.pop(context);
            },
          )

        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo", ""),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              if(kIsWeb) onWeb() else if(Platform.isAndroid) onAndroid(),
            ],
          ),
          Positioned(
            left: 10,
            top: 20,
            child: Container(
              color: Colors.white,
              height: 55,
              width: 55,
              child: IconButton(
                icon: Icon(Icons.menu_sharp,
                    color: Theme
                        .of(context)
                        .primaryColor, size: 40),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
