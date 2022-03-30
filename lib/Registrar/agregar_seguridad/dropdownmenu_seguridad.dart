import 'package:flutter/material.dart';

class DropDownMenuSeguridad extends StatefulWidget{
  @override
  _DropDownMenuSeguridad createState() => _DropDownMenuSeguridad();
}

class _DropDownMenuSeguridad extends State<DropDownMenuSeguridad> {

  // Initial Selected Value
  String dropdownvalue = 'Reconocimiento facial';

  // List of items in our dropdown menu
  var items = [
    'Reconocimiento facial',
    'NFC',
    'PIN',
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
      },
    );
  }
}