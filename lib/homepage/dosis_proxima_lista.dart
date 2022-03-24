import 'package:flutter/material.dart';
import 'dosis_proxima.dart';

class DosisProximaLista extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DosisProximas("Gastritis", "10:00 AM", "Lun a Vie"),
        DosisProximas("Asma","10:00 AM","Diario")
      ],
    );
  }
}