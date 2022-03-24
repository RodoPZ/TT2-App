import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/time_picker.dart';
import 'package:tt2/Registrar/agregar_horarios/dropdownmenu_horarios.dart';
import 'package:tt2/Registrar/agregar_horarios/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';

class AgregarHorariosMain extends StatefulWidget {
  @override
  _AgregarHorariosMain createState() => _AgregarHorariosMain();
}

class _AgregarHorariosMain extends State<AgregarHorariosMain> {
  final _preferencesService = PreferencesService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _horarioHora = "";
  late String _horarioRepetir = "";
  late bool isFull = false;

  Widget _buildHora() {
    return TimePickers((value) {
      setState(() {
        _horarioHora = value!;
      });
    });
  }

  Widget _buildRepetir() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Repetir: ",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
          ),
        ),
        DropDownMenuHorarios((value) {
          _horarioRepetir = value!;
        }),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _showalert();
  }

  _showalert() async {
    final horarios = await _preferencesService.getHorario();
    if (horarios.length == 100) {
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
                "No se pueden registrar mas horarios (100 horarios registrados), no puede registrar nuevos horarios hasta que elimine algunos.",
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_alarm,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Agregar horarios",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    Instrucciones(),
                    const SizedBox(height: 30),
                    _buildHora(),
                    const SizedBox(height: 30),
                    _buildRepetir(),
                    const SizedBox(height: 30),
                    ButtonMain(
                        buttonText: isFull ? "Lista llena" : "Agregar",
                        color: isFull
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        callback: () {
                          if (_horarioHora != "" && _horarioRepetir != "" && isFull == false) {
                            _registerHorarios();
                            const snackBar = SnackBar(
                              content:
                                  Text('Horario guardado!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                          } else if(isFull){
                            return;
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Faltan datos'),
                            );
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
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

  _registerHorarios() {
    final newHorario =
        Horario(horarioHora: _horarioHora, horarioRepetir: _horarioRepetir);
    _preferencesService.saveHorario(newHorario);
  }
}
