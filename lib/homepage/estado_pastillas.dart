import 'package:flutter/material.dart';

class EstadoPastillas extends StatelessWidget{

  final double textSize = 16;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("1 | Paracetamol | Status: ok",style: TextStyle(fontSize: textSize)),
          Text("2 | Paracetamol | Status: ok",style: TextStyle(fontSize: textSize)),
          Text("3 | Paracetamol | Status: ok",style: TextStyle(fontSize: textSize)),
          Text("4 | Paracetamol | Status: ok",style: TextStyle(fontSize: textSize)),
          Text("5 | Paracetamol | Status: ok",style: TextStyle(fontSize: textSize)),
        ],
      ),
    );
  }
}