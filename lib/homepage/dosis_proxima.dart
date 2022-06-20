import 'dart:async';
import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:tt2/Components/datetimeExtension.dart';
import 'package:tt2/SaveRead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tt2/Components/httpComunications.dart';
import 'dart:core';
class DosisProximas extends StatefulWidget{
  late String doseName;
  late String doseTime;
  late var doseDays;
  late var id;
  late var date;
  late Map historial;

  DosisProximas(this.doseName, this.doseTime, this.doseDays,this.id,this.date, this.historial, {Key? key}) : super(key: key);

  @override
  State<DosisProximas> createState() => _DosisProximasState();
}

class _DosisProximasState extends State<DosisProximas> {
  String texto = "";
  bool loaded = false;
  final _readWrite = SaveRead();
  late List dosisList = [];
  late Map dosisMap= {};
  late List contactosList = [];
  late Map isDispensadoList;
  late bool isDispensado = false;
  final _http = HTTP();
  late Duration lastDate = Duration(seconds: 0);
  late List nextDateList;
  late List alarm_day = [];
  late int endTime;
  late List httpDosis;
  late bool unavez = false;
  late var _contactos;

  Widget onAndroid() {
    return Column(
      children: [
        Text(
          "Dirígase al dispensador para obtener su dosis",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems({bool esperar = false}) async {
    if(esperar==true){
      setState(() => {
        isDispensado = true
      });
    }
    if(widget.doseDays.toString() == "Diariamente") {
      alarm_day = [1, 2, 3, 4, 5, 6, 7];
    }
    else if(widget.doseDays.toString() == "Una vez") {
      final now = DateTime.now();
      var ScheduledToday = DateTime(now.year,now.month,now.day,int.parse(widget.doseTime.substring(0,2)),int.parse(widget.doseTime.substring(3,5)));
      alarm_day = [ScheduledToday.isBefore(now)?now.weekday+1:now.weekday];
    }
    else if(widget.doseDays.toString() == "Lun a Vie"){
      alarm_day = [1,2,3,4,5];
    }
    else{
      for (var day in widget.doseDays) {
        if (day == "Lu") {
          alarm_day.add(1);
        }
        if (day == "Ma") {
          alarm_day.add(2);
        }
        if (day == "Mi") {
          alarm_day.add(3);
        }
        if (day == "Ju") {
          alarm_day.add(4);
        }
        if (day == "Vi") {
          alarm_day.add(5);
        }
        if (day == "Sa") {
          alarm_day.add(6);
        }
        if (day == "Do") {
          alarm_day.add(7);
        }
      }
    }
    nextDateList = [];
    for(var i in alarm_day){
      nextDateList.add(DateTime(DateTime.now().next(i).year,DateTime.now().next(i).month,DateTime.now().next(i).day,int.parse(widget.doseTime.substring(0,2)),int.parse(widget.doseTime.substring(3,5))).difference(DateTime.now()));
      if(nextDateList.last.isNegative){
        lastDate = nextDateList.last;
        nextDateList.removeLast();
      }
    }
    nextDateList.sort((a, b) => a.compareTo(b));
    if(nextDateList.length==0) {
      nextDateList.add(lastDate + Duration(days: 7));
    }
    contactosList = await _readWrite.getContacto();
    dosisList = await _readWrite.getDosis();

    for(var dosis in dosisList){
      if(dosis["serverid"] == widget.id){
        setState(() => dosisMap = dosis);
      }
    }
    if(widget.historial.containsKey(DateTime.now().toString().substring(0,10))){
      setState(() => isDispensado = true);
    }

    setState(() {
      print(DateTime.now().add(nextDateList[0]));
      endTime = DateTime.now().add(DateTime.parse(widget.date).difference(DateTime.now())).millisecondsSinceEpoch + 1000*2;
       loaded = true;
    });
  }

  Widget onWeb() {
    _contactos = dosisMap["alarmas"].sublist(2);
    late String _listDeContactos = "";
    if(_contactos.isNotEmpty){
      for(var contacto in contactosList){
        for(var numero in dosisMap["alarmas"].sublist(2)){
          if(numero == contacto["serverid"]){
            _listDeContactos += " " + contacto["numero"].toString();
          }
        }
      }
    }else{
      _listDeContactos = "0";
    }
    httpDosis=[widget.doseName,dosisMap["pastillas"], widget.doseTime,widget.doseDays,widget.id,dosisMap["seguridad"],_listDeContactos];
    _listDeContactos = "";
    String encoded = jsonEncode(httpDosis);
    return Container(
      height: 30,
      width: 150,
      child: ButtonMain(buttonText: "Dispensar", callback: () async {
        String _result = await _http.DispensarDosis(encoded);
        if(_result=="True"){
          _getItems();
        }
      }),
    );

  }

  Widget CountDown() {
    // print(widget.date);
    // print(DateTime.now().difference(DateTime.parse(widget.date)).inMinutes);
    // print(isDispensado);
    // print(DateTime.now().isAfter(DateTime.parse(widget.date)));
    if(unavez == true){
      return SizedBox();
    }
    if(isDispensado == false && DateTime.now().isAfter(DateTime.parse(widget.date)) && DateTime.now().difference(DateTime.parse(widget.date)).inMinutes<=(1)){ //En caso de que pase 1 hora despues de la dosis
      print("caso 5: no es de 1 vez y no han pasado 2 horas y no se ha dispensado");
      if(kIsWeb) return onWeb(); else return onWeb();
    }
    else if(isDispensado == false && DateTime.now().isAfter(DateTime.parse(widget.date)) && DateTime.now().difference(DateTime.parse(widget.date)).inMinutes>=(1)){ //En caso de que pase 1 hora despues de la dosis
      print("caso 6: no es de 1 vez y ya han pasado 2 horas y no se ha dispensado");
      if(widget.doseDays.toString() == "Una vez"){
        FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/').doc(widget.id).update({"horario":""});
        setState(() => unavez = true);
      }else{
        FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/').doc(widget.id).update({"date":DateTime.now().add(nextDateList[0]).toString()});
        widget.date = DateTime.now().add(nextDateList[0]).toString();
      }
      FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/').doc(widget.id).set({"historial" : {DateTime.now().toString().substring(0,10) : "false"}},SetOptions(merge: true));
      _getItems(esperar: true);
      return SizedBox();
    }
    else{
      print("caso 7: falta tiempo");
      return CountdownTimer(
      endTime: endTime,
      onEnd: ()=> _getItems(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          right: 20,
          left: 20
      ),
      width: double.infinity,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.black,
          ),
          onPressed: () {
            debugPrint('Received click');
          },
          child:
          Column(
              children: [
                SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.doseName),
                Text(widget.doseTime),
                Text(widget.doseDays.toString())
              ],
            ),
                SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                loaded == true? CountDown(): SizedBox()
              ],
            ),
                SizedBox(height: 5),
          ]
          )
      ),

    );
  }
}