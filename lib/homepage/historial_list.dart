import 'package:flutter/material.dart';
import 'historial.dart';
import 'package:tt2/SaveRead.dart';

class HistorialList extends StatefulWidget{
  @override
  State<HistorialList> createState() => _HistorialListState();
}

class _HistorialListState extends State<HistorialList> {

  final _readWrite = SaveRead();
  late List dosisList = [];
  bool loaded = false;
  late List dates = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    dosisList = await _readWrite.getDosis();
    for(var dosis in dosisList){
      dosis["historial"].forEach((key,value){
        dates.add({"date": key,"hour":value, "dispensado": value=="false"?false:true,"dosis": dosis["serverid"], "nombre": dosis["nombre"]});
      });
    }

    dates.sort((a,b) {
      var adate = a["date"];
      var bdate = b["date"];
      return bdate.compareTo(adate);
    });
    setState(() {
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
   return Container(
     child: Column(
       children: [
         for (var item in dates) Historial(item["nombre"], item["date"].substring(0,10), item["hour"].toString(), item["dispensado"]),
       ],
     ),
   );
  }
}