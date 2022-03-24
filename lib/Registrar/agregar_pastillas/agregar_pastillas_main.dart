import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Registrar/agregar_pastillas/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';

class AgregarPastillasMain extends StatefulWidget {
  @override
  State<AgregarPastillasMain> createState() => _AgregarPastillasMainState();
}

class _AgregarPastillasMainState extends State<AgregarPastillasMain> {
  final _preferencesService = PreferencesService();
  bool isFull = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _pastillaNombre;
  late int _pastillaCantidad;
  late String _pastillaCaducidad;

  Widget _buildNombre() {
    return InputText(
      inputText: "Nombre:",
      inputHintText: "Nombre de pastillas",
      inputmax: 20,
      textSize: 16,
      enabled: !isFull,
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
      enabled: !isFull,
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
      enabled: !isFull,
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
  void initState() {
    super.initState();
    _showalert();
  }

  _showalert() async {
    final pastillas = await _preferencesService.getPastilla();
    if (pastillas.length == 10) {
      _showAlert(context);
      setState(() {
        isFull = true;
      });
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Atención!"),
              content: const Text(
                "Los contenedores están llenos (10 pastillas registradas), no puede registrar nuevas pastillas hasta que elimine pastillas, pero puede abrir el compartimento.",
                textAlign: TextAlign.justify,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.pop(context, 'ok'),
                      child: const Text('ok',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Agregar pastillas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
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
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildNombre(),
                            Row(
                              children: [
                                Container(
                                  width: 170,
                                  child: _buildCantidad(),
                                ),
                                Spacer(),
                                Container(
                                  width: 170,
                                  child: _buildCaducidad(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),
                    ButtonMain(
                        buttonText:
                            isFull ? "Contenedores llenos" : "Registrar",
                        color: isFull
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        callback: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          _registerPastillas();
                          if (isFull == false) {
                            const snackBar = SnackBar(
                              content:
                                  Text('Información de pastillas guardada!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                          }
                        }),
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

  _registerPastillas() {
    final newPastilla = Pastilla(
        pastillaNombre: _pastillaNombre,
        pastillaCantidad: _pastillaCantidad,
        pastillaCaducidad: _pastillaCaducidad);
    _preferencesService.savePastilla(newPastilla);
  }
}
