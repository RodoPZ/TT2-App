import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../SaveRead.dart';
import 'dosis_proxima.dart';


class DosisProximaLista extends StatefulWidget{
  @override
  State<DosisProximaLista> createState() => _DosisProximaListaState();
}

class _DosisProximaListaState extends State<DosisProximaLista> {
  final _readWrite = SaveRead();
  late List items = [];
  late List horarios = [];
  late List showHorarios = [];
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    setState(() {
      loaded = false;
    });
    items = await _readWrite.getDosis();
    horarios = await _readWrite.getHorario();


    for (var item in items) {
      if(item["horario"]!=""){
        var querySnapshot = await FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/').doc(item["horario"]).get();
        showHorarios.add([item["nombre"],querySnapshot.data()!["hora"],querySnapshot.data()!["repetir"],item["serverid"],item["date"],item["historial"]]);
      }
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showHorarios.length*70,
      child:  ListView.builder(
        itemCount: showHorarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: DosisProximas(showHorarios[index][0],showHorarios[index][1],showHorarios[index][2],showHorarios[index][3],showHorarios[index][4],showHorarios[index][5]),
          );
        },
      ),
    );

  }
}