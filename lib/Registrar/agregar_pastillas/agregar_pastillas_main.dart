import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Registrar/agregar_pastillas/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';
import 'package:tt2/Components/item_manager.dart';

import '../../Components/button_icon.dart';

class AgregarPastillasMain extends StatefulWidget {
  @override
  State<AgregarPastillasMain> createState() => _AgregarPastillasMainState();
}

class _AgregarPastillasMainState extends State<AgregarPastillasMain> {
  final _preferencesService = PreferencesService();
  late List items = [];
  late List<bool> _selected;
  bool loaded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  late String _pastillaNombre = "";
  late int _pastillaCantidad = 0;
  late String _pastillaCaducidad = "";

  Widget _buildNombre() {
    return InputText(
      inputText: "Nombre:",
      inputHintText: "Nombre de pastillas",
      inputmax: 20,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo", ""),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 15,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 30),
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
                      child: ButtonMain(
                          buttonText: "Abrir compartimento", callback: () {}),
                    ),

                    ItemManager(
                      deleter:_preferencesService.deletePastilla,
                        getter: _preferencesService.getPastilla,
                        formTitle: "Registrar pastillas",
                        title: "Pastillas",
                        icono: Icons.medication,
                        form_items: formItems,
                        register: _registerPastillas,
                        callback: (){
                          _registerPastillas();
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
              ),
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
                    color: Theme.of(context).primaryColor, size: 40),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formItems(){
    return Column(
      children: [
        _buildNombre(),
        _buildCantidad(),
        _buildCaducidad(),
      ],
    );
  }

  _registerPastillas() {
    final newPastilla = Pastilla(
        pastillaNombre: _pastillaNombre,
        pastillaCantidad: _pastillaCantidad,
        pastillaCaducidad: _pastillaCaducidad);
    _preferencesService.savePastilla(newPastilla);
  }
}
