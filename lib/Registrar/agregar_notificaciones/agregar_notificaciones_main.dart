import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/models.dart';
import 'package:tt2/Components/button_icon.dart';
import 'package:tt2/preferences_service.dart';

class AgregarNotificacionesMain extends StatefulWidget {
  @override
  _AgregarNotificacionesMain createState() => _AgregarNotificacionesMain();
}

class _AgregarNotificacionesMain extends State<AgregarNotificacionesMain>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _preferencesService = PreferencesService();
  bool isFull = false;
  late String _contactoNombre;
  late int _contactoNumero;
  late List items = [];
  late List<bool> _selected;
  int _numberSelected = 0;

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _getItems();
    _controller = TabController(length: 2, vsync: this);
  }
  _getItems() async {
    items = await _preferencesService.getContacto();
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

  Widget _buildContactoNombre() {
    return InputText(
      inputText: "Nombre:",
      inputHintText: "Nombre del contacto",
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
        _contactoNombre = value!;
      },
    );
  }

  Widget _buildCantidad() {
    return InputText(
      inputText: "Numero: ",
      inputHintText: "Numero de telefono",
      inputType: TextInputType.number,
      textSize: 16,
      enabled: !isFull,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un numero";
        } else if (!RegExp(r'\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})').hasMatch(value)) {
          return "formato invalido: 492 xxx xxxx";
        }
        return null;
      },
      myOnSave: (String? value) {
        _contactoNumero = int.parse(value!);
      },
    );
  }


  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Atención!"),
              content: const Text(
                "La lista de contactos está llena (20 contactos) intente eliminando contactos para agregar más",
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
                height: 360,
                child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                        child: ListTile(
                            selected: _selected[index]?true:false,
                            selectedColor: Theme.of(context).primaryColor,
                            leading: const Icon(Icons.person),
                            title: Text(items[index][0]),
                            subtitle: Text(items[index][1].toString()),
                            trailing: ButtonIcon(color: Theme.of(context).primaryColor,icon: Icons.delete, callBack: (){
                              _preferencesService.deleteContacto(index);
                              _getItems();
                            })),
                      );
                    }),
              ),
            ],
          ),
        );
      } else {
        return const Text("No hay nada que mostrar",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ));
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
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          "Agregar Notificaciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: TabBar(
                        controller: _controller,
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.message),
                            text: 'Mensajes',
                          ),
                          Tab(
                            icon: Icon(Icons.contacts),
                            text: 'Contactos',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500.0,
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text(
                                  'Latitude: 48.09342\nLongitude: 11.23403'),
                              trailing: IconButton(
                                  icon: const Icon(Icons.my_location),
                                  onPressed: () {}),
                            ),
                          ),
                          Card(
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
                                        "Contactos",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ButtonIcon(
                                          color: Theme.of(context).primaryColor,
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
                        child:_buildContactoNombre(),
                      ),
                      Padding(padding:const EdgeInsets.all(8.0),
                        child:_buildCantidad(),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                        buttonText: "Registrar",
                        callback: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          _registerContactos();
                          if (isFull == false) {
                            const snackBar = SnackBar(
                              content: Text(
                                  'Información de pastillas guardada!'),
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

  _registerContactos() {
    final newContacto = Contacto(
        contactoNombre: _contactoNombre,
        contactoNumero: _contactoNumero);
    _preferencesService.saveContacto(newContacto);
  }
}
