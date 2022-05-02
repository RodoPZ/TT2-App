import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../SaveRead.dart';
import 'package:collection/collection.dart';
import 'package:tt2/Components/button_icon.dart';

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
  final _preferencesService = SaveRead();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async{
    _dosisList = await _preferencesService.getDosis();
    _horariosList = await _preferencesService.getHorario();
    _pastillasList = await _preferencesService.getPastilla();
    _contactosList = await _preferencesService.getContacto();
    setState(() {
      loaded = true;
    });
  }

  Widget _displayHora(index){
    List _hora = [];
    List _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
      for(var j in _item){
        if(i['id'] == j){
          _hora.add(i['hora']);
        }
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var item in _hora) Text(item.toString()),
      ],
    );
  }

  Widget _displayRepetir(index){
    List _repetir = [];
    List _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
      for(var j in _item){
        if(i['id'] == j){
          _repetir.add(i['repetir']);
        }
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var item in _repetir) Text(item.toString()),
      ],
    );
  }

  Widget _displayAlertas(index){
    List _alertas = [];
    List _item = _dosisList[index]['alarmas'];
    if(_item[0] == true){
      _alertas.add(Icons.doorbell);
    }
    if(_item[1] == true){
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


  @override
  Widget build(BuildContext context) {
    if (loaded == true){
      return DataTable(
        showCheckboxColumn: false,
        columnSpacing: 10,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Nombre',
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
              '',
              style: TextStyle(),
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
            DataCell(Text(element["nombre"].toString())),
            DataCell(_displayHora(index)),
            DataCell(_displayRepetir(index)),
            DataCell(_displayAlertas(index)),
            DataCell(Text(element["seguridad"].toString())),
            DataCell(ButtonIcon(
              iconSize: 30,
              icon: Icons.delete,
              color: Theme.of(context).primaryColor,
              callBack: () {
                _preferencesService.deleteDosis(index);
                _getItems();
              },
            )),
          ],
        )
        ).toList(),
      );
    }
    else{
      return SizedBox();
    }
  }

  Widget _formHora(index){
    List _hora = [];
    List _repetir = [];
    List _item = _dosisList[index]['horario'];
    for (var i in _horariosList) {
      for(var j in _item){
        if(i['id'] == j){
          _hora.add(i['hora']);
          _repetir.add(i['repetir']);
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < _hora.length; i++) Row(
          children: [
            const SizedBox(width: 10),
            Text(_hora[i].toString()),
            const SizedBox(width: 10),
            Text(_repetir[i].toString()),
          ],
        ),
      ],
    );
  }

  Widget _formPastillas(index){
    List _pastillas = [];
    List _caducidad = [];
    List _item = [];
    List _cantidad =[];

    for(var ids in _dosisList[index]['pastillas']){
      _item.add(ids[0]);
      _cantidad.add(ids[1]);
    }
    for (var i in _pastillasList) {
      for(var j in _item){
        if(i['id'] == j){
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
        if(i['id'] == _item[j]){
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
            Text(_contacto[i].toString()),
            const SizedBox(width: 20),
            Text(_numero[i].toString()),
          ],
        ),
      ],
    );
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
                          Text("Horarios: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          _formHora(index),
                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Alertas: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          _formAlertas(index),
                        ],
                      ),
                      Divider(thickness: 2),
                      Row(
                        children: [
                          Text("Seguridad: ",style: TextStyle(color: Theme.of(context).primaryColor)),
                          _formAlertas(index),
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