import 'package:flutter/material.dart';
import 'package:tt2/Registrar/agregar_horarios/popup_days.dart';

class DropDownMenuNotificaciones extends StatefulWidget{
  late Function(String) value;

  DropDownMenuNotificaciones({required this.value ,Key? key}) : super(key: key);


  @override
  _DropDownMenuNotificaciones createState() => _DropDownMenuNotificaciones();
}

class _DropDownMenuNotificaciones extends State<DropDownMenuNotificaciones> {

  // Initial Selected Value
  String dropdownvalue = 'Seleccionar..';

  // List of items in our dropdown menu
  var items = [
    'Seleccionar..',
    'Notificación',
    'Dispensador',
    'SMS',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownvalue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
        widget.value(dropdownvalue);
      },
    );
  }
}