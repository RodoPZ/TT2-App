import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/models.dart';
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

  final List<bool> _isEmpty = [true, true, true, false];
  late String _dosisNombre;
  List _pastillaData = [];
  List _horarioData = [];
  List _alarmaData = [true, true];
  List _seguridadData = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    Widget _errorText() {
      if (_isEmpty[1] == true) {
        return const Text(
          "No puede estar vacío",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.red,
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return Column(
      children: [
        Section(
            getter: _preferencesService.getPastilla,
            intSelection: 0,
            formText: "Seleccionar pastillas",
            selected: (items) {
              setState(() => _isEmpty[1] = false);
              _pastillaData = items;
            },
            sectionName: "Pastillas",
            firstColText: 'Nombre',
            secondColText: "Cantidad"),
        _errorText(),
      ],
    );
  }

  Widget _buildHorario() {
    Widget _errorText() {
      if (_isEmpty[2] == true) {
        return const Text(
          "No puede estar vacío",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.red,
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return Column(
      children: [
        Section(
            getter: _preferencesService.getHorario,
            intSelection: 1,
            formText: "Seleccionar Horario",
            selected: (items) {
              setState(() => _isEmpty[2] = false);
              _horarioData = items;
            },
            sectionName: "Horario",
            firstColText: 'Hora',
            secondColText: "Repetir"),
        _errorText(),
      ],
    );
  }

  Widget _buildAlarmas() {
    Widget _errorText() {
      if (_isEmpty[3] == true) {
        return const Text(
          "No puede estar vacío",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.red,
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return Column(
      children: [
        Section(
            getter: _preferencesService.getContacto,
            intSelection: 1,
            formText: "Seleccionar Contacto",
            selected: (items) {
              setState(() => _isEmpty[3] = false);
              items.insert(0, valuesecond);
              items.insert(0, valuefirst);
              _alarmaData = items;
            },
            sectionName: "Alarmas",
            firstColText: 'Contacto',
            secondColText: "Numero"),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Theme.of(context).primaryColor,
          secondary:
              Icon(Icons.upcoming, color: Theme.of(context).primaryColor),
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
          secondary:
              Icon(Icons.upcoming, color: Theme.of(context).primaryColor),
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
        _errorText(),
      ],
    );
  }

  Widget _buildSeguridad() {
    return Section(
      getter: _preferencesService.getContacto,
      intSelection: 1,
      formText: "Seleccionar Seguridad",
      selected: (items) {
      },
      sectionName: "Seguridad",
      firstColText: 'Seguridad',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          },
        child: Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Dosis",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const Divider(thickness: 2),
                        Form(
                          key: _formKey,
                          child: _buildDosisNombre(),
                        ),
                        const SizedBox(height: 20),
                        _buildPastillas(),
                        const Divider(thickness: 2),
                        _buildHorario(),
                        const Divider(thickness: 2),
                        _buildAlarmas(),
                        const Divider(thickness: 2),
                        _buildSeguridad(),
                        const SizedBox(height: 20),
                        ButtonMain(
                            buttonText: "Registrar",
                            callback: () {
                              if (!_formKey.currentState!.validate()) {
                                setState(() => _isEmpty[0] = true);
                              } else {
                                setState(() => _isEmpty[0] = false);
                              }

                              if (_pastillaData.isEmpty) {
                                setState(() => _isEmpty[1] = true);
                              } else {
                                setState(() => _isEmpty[1] = false);
                              }

                              if (_horarioData.isEmpty) {
                                setState(() => _isEmpty[2] = true);
                              } else {
                                setState(() => _isEmpty[2] = false);
                              }

                              if (_alarmaData.isEmpty &&
                                  (valuefirst == false && valuesecond == false)) {
                                setState(() => _isEmpty[3] = true);
                              } else {
                                setState(() => _isEmpty[3] = false);
                                _alarmaData[0] = valuefirst;
                                _alarmaData[1] = valuesecond;
                              }
                              _formKey.currentState!.save();
                              if (_isEmpty.every((element) => element == false)) {
                                _registerDosis();
                                const snackBar = SnackBar(
                                  content:
                                  Text('Información de Dosis guardada!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              } else {
                                return;
                              }
                            }),
                        const SizedBox(height: 20),
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
        ),
    );
  }

  _registerDosis() {
    final newDosis = Dosis(
        dosisNombre: _dosisNombre,
        pastillaData: _pastillaData,
        horarioData: _horarioData,
        alarmaData: _alarmaData,
        seguridadData: _seguridadData);
    _preferencesService.saveDosis(newDosis);
  }
}
