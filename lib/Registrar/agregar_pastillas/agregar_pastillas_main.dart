import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Registrar/agregar_pastillas/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/preferences_service.dart';

import '../../Components/button_icon.dart';

class AgregarPastillasMain extends StatefulWidget {
  @override
  State<AgregarPastillasMain> createState() => _AgregarPastillasMainState();
}

class _AgregarPastillasMainState extends State<AgregarPastillasMain> {
  final _preferencesService = PreferencesService();
  bool isFull = false;

  late List items = [];
  late List<bool> _selected;
  bool loaded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
    _getItems();
  }
  _getItems() async {
    items = await _preferencesService.getPastilla();
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
                              _preferencesService.deletePastilla(index);
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
                        child:_buildNombre(),
                      ),
                      Padding(padding:const EdgeInsets.all(8.0),
                        child:_buildCantidad(),
                      ),
                      Padding(padding:const EdgeInsets.all(8.0),
                        child:_buildCaducidad(),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
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
                          setState(() {
                            _getItems();
                          });
                        }))
              ],
            ),
          );
        });
  }

  _registerPastillas() {
    final newPastilla = Pastilla(
        pastillaNombre: _pastillaNombre,
        pastillaCantidad: _pastillaCantidad,
        pastillaCaducidad: _pastillaCaducidad);
    _preferencesService.savePastilla(newPastilla);
  }
}
