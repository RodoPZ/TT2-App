import 'package:flutter/material.dart';
import 'package:tt2/SaveRead.dart';
class EstadoPastillas extends StatefulWidget{

  @override
  State<EstadoPastillas> createState() => _EstadoPastillasState();
}

class _EstadoPastillasState extends State<EstadoPastillas> {
  bool loaded = false;
  final _readWrite = SaveRead();
  final double textSize = 16;
  List _pastillasList = [];
  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    setState(() {
      loaded = false;
    });
    _pastillasList = await _readWrite.getPastilla();

    setState(() {
      loaded = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i in _pastillasList) Text("["+i["contenedor"].toString()+"]  "+i["nombre"] + " - cantidad:" + i["cantidad"].toString() + " - caducidad: " + i["caducidad"],
                style: TextStyle(
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}