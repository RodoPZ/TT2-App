import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/input_text.dart';
import '../../preferences_service.dart';
import 'section.dart';

class CrearDosisMain extends StatefulWidget {
  @override
  _CrearDosisMain createState() => _CrearDosisMain();
}

class _CrearDosisMain extends State<CrearDosisMain> {
  bool valuefirst = true;
  bool valuesecond = true;
  final _preferencesService = PreferencesService();

  late String _dosisNombre;
  late List _pastillaData;
  late List _horarioData;
  late List _alarmaData;
  late List _seguridadData;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildDosisNombre() {
    return InputText(
      inputHintText: "Nombre de la dosis",
      inputmax: 20,
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un nombre";
        }
        return null;
      },
      myOnSave: (String? value) {
        _dosisNombre = value!;
      },
    );
  }

  Widget _buildPastillas() {
    return Section(
        getter: _preferencesService.getPastilla,
        intSelection: 0,
        formText: "Seleccionar pastillas",
        selected: (items) {
          print(items);
        },
        sectionName: "Pastillas",
        firstColText: 'Nombre',
        secondColText: "Cantidad");
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
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Dosis",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    InputText(inputHintText: "Nombre de la dosis"),
                    const SizedBox(height: 20),
                    _buildPastillas(),
                    Divider(thickness: 2),
                    Section(
                        getter: _preferencesService.getHorario,
                        intSelection: 1,
                        formText: "Seleccionar Horario",
                        selected: (items) {
                          print(items);
                        },
                        sectionName: "Horario",
                        firstColText: 'Hora',
                        secondColText: "Repetir"),
                    Divider(thickness: 2),
                    Section(
                        getter: _preferencesService.getContacto,
                        intSelection: 1,
                        formText: "Seleccionar Contacto",
                        selected: (items) {
                          print("awa: " + items.toString());
                        },
                        sectionName: "Alarmas",
                        firstColText: 'Contacto',
                        secondColText: "Numero"),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Theme.of(context).primaryColor,
                      secondary: Icon(Icons.upcoming,color: Theme.of(context).primaryColor),
                      title: const Text(
                        '¿Activar alarma de dispensador?',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      value: valuefirst,
                      onChanged: (bool? value) {
                        setState(() {
                          valuefirst = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Theme.of(context).primaryColor,
                      secondary: Icon(Icons.upcoming,color: Theme.of(context).primaryColor),
                      title: const Text(
                        '¿Activar notificaciones del celular?',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      value: valuesecond,
                      onChanged: (bool? value) {
                        setState(() {
                          valuesecond = value!;
                        });
                      },
                    ),
                    Divider(thickness: 2),
                    Section(
                        getter: _preferencesService.getContacto,
                        intSelection: 1,
                        formText: "Seleccionar Seguridad",
                      selected: (items) {
                        print(items);
                      },
                        sectionName: "Seguridad",
                        firstColText: 'Seguridad',
                    ),
                    SizedBox(height: 15),
                    ButtonMain(buttonText: "Registrar", callback: (){

                    })
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
}
