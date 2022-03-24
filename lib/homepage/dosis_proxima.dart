import 'package:flutter/material.dart';
class DosisProximas extends StatelessWidget{
  late String doseName;
  late String doseTime;
  late String doseDays;
  DosisProximas(this.doseName, this.doseTime, this.doseDays, {Key? key}) : super(key: key);
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
        child: Row(
          children: [
            Text(doseName),
            Spacer(),
            Text(doseTime),
            Spacer(),
            Text(doseDays)
          ],
        ),
      ),
    );
  }
}