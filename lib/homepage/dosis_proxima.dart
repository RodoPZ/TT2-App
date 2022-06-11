import 'package:flutter/material.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:tt2/Components/datetimeExtension.dart';
import 'package:tt2/SaveRead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tt2/models.dart';
class DosisProximas extends StatefulWidget{
  late String doseName;
  late String doseTime;
  late var doseDays;
  late var id;
  late var date;

  DosisProximas(this.doseName, this.doseTime, this.doseDays,this.id,this.date, {Key? key}) : super(key: key);

  @override
  State<DosisProximas> createState() => _DosisProximasState();
}

class _DosisProximasState extends State<DosisProximas> {
  String texto = "";
  bool loaded = false;
  final _readWrite = SaveRead();
  late List dosisList = [];
  late DateTime nextDate;
  late Duration lastDate = Duration(seconds: 0);
  late List nextDateList;
  late List alarm_day = [];
  @override
  void initState() {
    super.initState();
    _getItems();
  }
  _getItems() async {

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
    nextDate = DateTime.now().add(nextDateList[0]);

    setState(() {
      loaded = true;
    });
    dosisList = await _readWrite.getDosis();
  }

  Widget CountDown(){
    print(alarm_day);
    if(widget.doseDays.toString() == "Una vez"){
      if(DateTime.now().isAfter(DateTime.parse(widget.date)) && DateTime.now().difference(nextDate).inMinutes<=-(24*60-1)){
        print("caso 1: es de una vez y ha pasado menos de  1 hora");
        return SizedBox();
      }else if(DateTime.now().isAfter(DateTime.parse(widget.date)) && DateTime.now().difference(nextDate).inMinutes>=-(24*60-1)){
        print("caso 2: es de una vez y pasó 1 hora");
        FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/').doc(widget.id).update({"horario":""});
        return SizedBox();
      }
      else{
        print("caso 4: falta tiempo");
        return CountDownText(
          due: DateTime.parse(DateTime.now().add(nextDateList[0]).toString()),
          finishedText: "Done",
          showLabel: true,
          longDateName: true,
          daysTextLong: " Días ",
          hoursTextLong: " Horas ",
          minutesTextLong: " Minutos ",
          secondsTextLong: " Segundos ",
        );
      }
    }
    else if(lastDate.inMinutes>=-60 && lastDate.inMinutes<0){ //En caso de que pase 1 hora despues de la dosis
      print("caso 3: no es de 1 vez y no han pasado 2 horas ");
      return SizedBox();
    }else{
      print("caso 4: falta tiempo");
      return CountDownText(
        due: DateTime.parse(DateTime.now().add(nextDateList[0]).toString()),
        finishedText: "Done",
        showLabel: true,
        longDateName: true,
        daysTextLong: " Días ",
        hoursTextLong: " Horas ",
        minutesTextLong: " Minutos ",
        secondsTextLong: " Segundos ",
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
                CountDown(),
              ],
            ),
                SizedBox(height: 5),
          ]
          )
      ),

    );
  }
}