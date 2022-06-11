import 'package:flutter/material.dart';
class Historial extends StatelessWidget{
  late String doseHistoryName;
  late String doseHistoryTime;
  late String doseHistoryDays;
  late bool DoseHistoryStatus;
  Historial(this.doseHistoryName, this.doseHistoryTime, this.doseHistoryDays,this.DoseHistoryStatus, {Key? key}) : super(key: key);
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
          backgroundColor: DoseHistoryStatus==true?Colors.white:Colors.red.withOpacity(0.4),
        ),
        onPressed: () {
          debugPrint('Received click');
        },
        child: Row(
          children: [

            Text(doseHistoryName),
            Spacer(),
            Text(doseHistoryTime),
            Spacer(),
            Text(doseHistoryDays),
            Spacer(),
            DoseHistoryStatus?Icon(Icons.check,color: Colors.green): Icon(Icons.close,color: Colors.red),
          ],
        ),
      ),
    );
  }
}