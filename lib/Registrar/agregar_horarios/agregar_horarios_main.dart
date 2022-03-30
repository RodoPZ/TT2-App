import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/time_picker.dart';
import 'package:tt2/Registrar/agregar_horarios/dropdownmenu_horarios.dart';
import 'package:tt2/Registrar/agregar_horarios/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';

import '../../Components/button_icon.dart';

class AgregarHorariosMain extends StatefulWidget {
  @override
  _AgregarHorariosMain createState() => _AgregarHorariosMain();
}

class _AgregarHorariosMain extends State<AgregarHorariosMain> {
  final _preferencesService = PreferencesService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List items = [];
  late List<bool> _selected;
  bool loaded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _horarioHora = "";
  String _horarioRepetir = "";
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
    _getItems();
  }
  _getItems() async {
    items = await _preferencesService.getHorario();
    setState(() {
      _selected = List.generate(items.length, (index) => false);
      loaded = true;
    });
    if (items.length == 1) {
      _showAlert(context);
      setState(() {
        isFull = true;
      });
    }else{
      setState(() {
        isFull = false;
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

  Widget printItems(){
    if (loaded == true){
      if (items.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 200,
                child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                        child: ListTile(
                            selected: _selected[index]?true:false,
                            selectedColor: Theme.of(context).primaryColor,
                            leading: const Icon(Icons.medication),
                            title: Text(items[index][0]),
                            subtitle: Text(items[index][1].toString()),
                            trailing: ButtonIcon(icon: Icons.delete, callBack: (){
                              _preferencesService.deleteHorario(index);
                              _getItems();

                            })),
                      );
                    }),
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text("No hay nada que mostrar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        );
      }
    }
    else{
      return Text("Error");
    }
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
                    Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: 30,
                              left: 30,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Pastillas",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ButtonIcon(
                                    icon: Icons.add,
                                    size: 30,
                                    callBack: () {
                                      _Form();
                                    })
                              ],
                            ),
                          ),
                          printItems(),
                        ],
                      ),
                    ),
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
  _Form(){
    return showDialog(
        context: context,
        builder:
            (BuildContext context) {
          return AlertDialog(
            content:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:MainAxisSize.min,
                    children: [
                      const Text("Registrar nuevo contacto",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )),
                      Padding(
                        padding:const EdgeInsets.all(8.0),
                        child:_buildHora(),
                      ),
                      Padding(padding:const EdgeInsets.all(8.0),
                        child:_buildRepetir(),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(

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
                            setState(() {
                              _getItems();
                              _horarioHora = "";
                              _horarioRepetir = "";
                            });
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
                )
              ],
            ),
          );
        });
  }
  _registerHorarios() {
    final newHorario =
        Horario(horarioHora: _horarioHora, horarioRepetir: _horarioRepetir);
    _preferencesService.saveHorario(newHorario);
  }
}
