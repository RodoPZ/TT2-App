import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/SaveRead.dart';
class OnClickNotificaciones extends StatelessWidget {
  final String? payload;
  const OnClickNotificaciones({Key? key, this.payload}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final _saveRead = SaveRead();
    
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Es la hora de su medicina!!!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            ),
              SizedBox(height: 30),
              ButtonMain(buttonText: "Iniciar dispensación", callback: (){
              _saveRead.pillSubstraction(payload!);
              Navigator.pop(context);
              })
          ],
        ),
      ),
    );
  }
}
