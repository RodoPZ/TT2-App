import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/models.dart';
import 'package:tt2/SaveRead.dart';
import 'package:tt2/Components/item_manager.dart';
import 'instrucciones.dart';

class AgregarContactosMain extends StatefulWidget {
  @override
  _AgregarContactosMain createState() => _AgregarContactosMain();
}

class _AgregarContactosMain extends State<AgregarContactosMain>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _readWrite = SaveRead();
  bool isFull = false;
  late String _contactoNombre;
  late int _contactoNumero;
  late List items = [];
  late List<bool> _selected;
  int _numberSelected = 0;

  bool loaded = false;

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

  Widget _buildContactoNumero() {
    return InputText(
      inputText: "Numero: ",
      inputHintText: "Numero de telefono",
      inputType: TextInputType.number,
      textSize: 16,
      enabled: !isFull,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un numero";
        } else if (!RegExp(r'\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})')
            .hasMatch(value)) {
          return "formato invalido: 492 xxx xxxx";
        }
        return null;
      },
      myOnSave: (String? value) {
        _contactoNumero = int.parse(value!);
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
                  top: 10,
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
                          Icons.person_add,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text(
                          "Contactos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    Instrucciones(),
                    const SizedBox(height: 20),
                    ItemManager(
                        dataSubTitle: ["numero"],
                        dataTitle: "nombre",
                        callback: () async {
                          await _registerContactos();
                          const snackBar = SnackBar(
                            content: Text('Información de contactos guardada!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        getter: _readWrite.getContacto,
                        deleter: _readWrite.deleteAll,
                        deleterName: "Contactos",
                        form_items: formItems,
                        register: _registerContactos,
                        icono: Icons.person,
                        title: "Contactos",
                        formTitle: "Registrar contactos"),
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

  Widget formItems() {
    return Column(
      children: [
        _buildContactoNombre(),
        _buildContactoNumero(),
      ],
    );
  }

  _registerContactos() async{
    final newContacto = Contacto(
        contactoNombre: _contactoNombre, contactoNumero: _contactoNumero);
    await _readWrite.saveContacto(newContacto);
  }
}
