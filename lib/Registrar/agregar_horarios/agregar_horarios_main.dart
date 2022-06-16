import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Components/time_picker.dart';
import 'package:tt2/Registrar/agregar_horarios/dropdownmenu_horarios.dart';
import 'package:tt2/Registrar/agregar_horarios/instrucciones.dart';
import 'package:tt2/models.dart';
import 'package:tt2/SaveRead.dart';
import 'package:tt2/Components/item_manager.dart';

class AgregarHorariosMain extends StatefulWidget {
  @override
  _AgregarHorariosMain createState() => _AgregarHorariosMain();
}

class _AgregarHorariosMain extends State<AgregarHorariosMain> {
  final _readWrite = SaveRead();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List items = [];
  late List<bool> _selected;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _horarioHora = "";
  var _horarioRepetir;

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
          if(value!= "Seleccionar" && value!= "Personalizado" ){
            _horarioRepetir = value;
          }
        }),
      ],
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
                          Icons.access_alarm,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Horarios",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),

                    const Divider(thickness: 2),
                    Instrucciones(),
                    const SizedBox(height: 30),
                    ItemManager(
                      dataSubTitle: const ["repetir"],
                      dataTitle: "hora",
                        getter: _readWrite.getHorario,
                        deleter: _readWrite.deleteAll,
                        deleterName: "Horarios",
                        form_items: formItems,
                        register: _registerHorarios,
                        icono: Icons.access_alarm,
                        title: "Alarmas",
                        formTitle: "Registrar Alarmas",
                        callback: () async{
                          if (_horarioHora != "" && _horarioRepetir != "") {
                            await _registerHorarios();

                            const snackBar = SnackBar(
                              content:
                              Text('Información de pastillas guardada!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pop(context);
                            setState(() {
                              _horarioHora = "";
                              _horarioRepetir = "";
                            });
                          }else{
                            return;
                          }
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
        _buildHora(),
        _buildRepetir(),
      ],
    );
  }

  _registerHorarios() async {
    final newHorario =
        Horario(horarioHora: _horarioHora, horarioRepetir: _horarioRepetir);
   await _readWrite.saveHorario(newHorario);
  }
}
