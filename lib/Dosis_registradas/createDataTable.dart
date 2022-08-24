import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../SaveRead.dart';
import 'package:collection/collection.dart';
import 'package:tt2/Components/button_icon.dart';
import 'package:tt2/Components/requireAdmin.dart';

class CreateDataTable extends StatefulWidget{
  @override
  _CreateDataTable createState() => _CreateDataTable();
}

class _CreateDataTable extends State<CreateDataTable>{
  bool loaded = false;
  List _dosisList = [];
  List _horariosList = [];
  List _pastillasList = [];
  List _contactosList = [];
  List _seguridadList = [];
  final _readWrite = SaveRead();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async{
    setState(() {
      loaded = false;
    });
    _dosisList = await _readWrite.getDosis();
    _horariosList = await _readWrite.getHorario();
    _pastillasList = await _readWrite.getPastilla();
    _contactosList = await _readWrite.getContacto();
    _seguridadList = await _readWrite.getSeguridad();
    setState(() {
      loaded = true;
    });
  }

  Widget _displayHora(index){
    String _hora = "";
    String _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
      if(i["serverid"] == _item){
        _hora = i['hora'];
      }
    }
    return Text(_hora);
  }

  Widget _displayRepetir(index){
    String _repetir = "";
    String _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
      if(i["serverid"] == _item){
        _repetir = i['repetir'].toString();
      }
    }
    return Text(_repetir);
  }

  Widget _displayAlertas(index){
    List _alertas = [];
    List _item = _dosisList[index]['alarmas'];

    if(_item[0] == true){
      _alertas.add(Icons.doorbell);
    }
    if(_item.length > 1 && _item[1] == true){
      _alertas.add(Icons.notifications_active);
    }
    if(_item.length > 2){
      _alertas.add(Icons.chat);
    }
    if(_item[0] == false && _item[0] == false && _item.length == 2){
      _alertas.add(Icons.close);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var item in _alertas) Icon(item,color: Theme.of(context).primaryColor),
      ],
    );
  }

  Widget _displaySeguridad(index){
    IconData _seguridad =  Icons.lock_open;
    String _item = _dosisList[index]['seguridad'];
    if(_item != "") {
      for(var i in _seguridadList){
        if(i["serverid"] == _item){
          if(i["tipo"] == "RECONOCIMIENTO FACIAL"){
            _seguridad = Icons.face;
          }else if(i["tipo"] == "PIN"){
            _seguridad = Icons.pin;
          }else{
            _seguridad = Icons.nfc;
          }
        }
      }
    }

    return Icon(_seguridad,color: Theme.of(context).primaryColor);
  }
  @override
  Widget build(BuildContext context) {
    if (loaded == true){
      if(_dosisList.isNotEmpty){
        return DataTable(
          showCheckboxColumn: false,
          columnSpacing: 5,
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Nombre',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Hora',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Repetir',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Alertas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Seguridad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Borrar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _dosisList.mapIndexed((index,element) => DataRow(
            onSelectChanged: (bool? selected) {
              if(selected==true){
                form(index,element);
              }
            },
            color: MaterialStateColor.resolveWith((states){
              if(_dosisList[index]['alarmas'][0] == false
                  && _dosisList[index]['alarmas'][1] == false
                  && _dosisList[index]['alarmas'].length == 2){
                return Colors.red.shade100;
              }else{
                return Colors.white;
              }
            }),
            cells: <DataCell>[
              DataCell(
                  Container(
                          width: MediaQuery.of(context).size.width*(1/8),
                          child: Text(element["nombre"].toString(),overflow: TextOverflow.ellipsis))
              ),
              DataCell(_displayHora(index)),
              DataCell(_displayRepetir(index)),
              DataCell(_displayAlertas(index)),
              DataCell(_displaySeguridad(index)),
              DataCell(ButtonIcon(
                iconSize: 30,
                icon: Icons.delete,
                color: Theme.of(context).primaryColor,
                callBack: () async {
                  RequireAdmin(context,  () async {
                    Navigator.pop(context);
                    await _readWrite.deleteAll(_dosisList[index]["serverid"],"Dosis");
                    _getItems();
                  },
                      () async {
                        await _readWrite.deleteAll(_dosisList[index]["serverid"],"Dosis");
                        _getItems();
                      });

                },
              )),
            ],
          )
          ).toList(),
        );
      }else{
        return Text("No hay Dosis guardadas!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
        );
      }

    }
    else{
      return CircularProgressIndicator(color: Theme.of(context).primaryColor) ;
    }
  }

  Widget _formHora(index){
    String _hora = "";
    String _repetir = "";
    String _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
        if(i["serverid"] == _item){
          _hora = i['hora'];
          _repetir = i['repetir'];
        }
    }
    return Text(_hora + " " + _repetir);
  }

  Widget _formPastillas(index){
    List _pastillas = [];
    List _caducidad = [];
    List _item = [];
    List _cantidad =[];

    for(var ids in jsonDecode(_dosisList[index]['pastillas'])){
      _item.add(ids[0]);
      _cantidad.add(ids[1]);
    }
    for (var i in _pastillasList) {
      for(var j in _item){
        if(i["serverid"] == j){
          _pastillas.add(i['nombre']);
          _caducidad.add(i['caducidad']);
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < _pastillas.length; i++) Row(
          children: [
            const SizedBox(width: 10),
            Text(_pastillas[i].toString()),
            const SizedBox(width: 20),
            Text(_cantidad[i].toString()),
          ],
        ),
      ],
    );
  }

  Widget _formAlertas(index){
    List _contacto = [];
    List _numero = [];
    List _item = _dosisList[index]['alarmas'];

    for (var i in _contactosList) {
      for(int j = 2; j < _item.length; j++ ){
        if(i["serverid"] == _item[j]){
          _contacto.add(i['nombre']);
          _numero.add(i['numero']);
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(_item[0] == true) Text("  Alarma de dispensador"),
        if(_item[0] == true) Text("  Notificaciones del celular"),
        for (var i = 0; i < _contacto.length; i++) Row(
          children: [
            const SizedBox(width: 10),
            Flexible(child: Text(_contacto[i].toString())),
            const SizedBox(width: 20),
            Flexible(child: Text(_numero[i].toString())),

          ],
        ),
      ],
    );
  }

  Widget _formSeguridad(index){
    String _item = _dosisList[index]['seguridad'];
    String _seguridad = "";
    for (var i in _seguridadList) {
      if(i["serverid"] == _item){
        print(i);
        _seguridad=i["tipo"];
      }
    }
    if(_seguridad.isEmpty){
      _seguridad="No configurada";
    }
    return Text(_seguridad);
  }


  form(index,element) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Información de la Dosis"),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Nombre: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          Text(element["nombre"].toString())
                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Pastillas: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          _formPastillas(index),
                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Horario: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          _formHora(index),
                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Alertas: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          Flexible(child: _formAlertas(index)),

                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [

                          Text("Seguridad: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          Flexible(child: _formSeguridad(index)),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}