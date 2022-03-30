import 'package:flutter/material.dart';
import 'historial.dart';
class HistorialList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Column(
       children: [
         Historial("doseHistory", "doseHistoryTime", "doseHistoryDays", true),
         Historial("doseHistory", "doseHistoryTime", "doseHistoryDays", false),
       ],
     ),
   );
  }
}