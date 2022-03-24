import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Registrar/agregar_horarios/popup_days.dart';

class DropDownMenuHorarios extends StatefulWidget {
  Function(String?)? onChange;

  DropDownMenuHorarios(this.onChange, {Key? key}) : super(key: key);

  @override
  _DropDownMenuHorarios createState() => _DropDownMenuHorarios();
}

class _DropDownMenuHorarios extends State<DropDownMenuHorarios> {
  // Initial Selected Value
  String dropdownvalue = 'Una vez';
  String lastSelection = "";

  // List of items in our dropdown menu
  var items = [
    'Una vez',
    'Diariamente',
    'Lun a Vie',
    'Personalizado',
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
        if (dropdownvalue == "Personalizado") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Elegir un día'),
              content: Container(
                  height: 340,
                  child: PopUpDays((value) {
                    setState(() {
                      if (lastSelection != "") {
                        items.removeLast();
                      }
                      items.add(value!);
                      dropdownvalue = value;
                      lastSelection = value;
                      widget.onChange!(dropdownvalue);
                    });
                  })),
            ),
          );
        }
        widget.onChange!(dropdownvalue);
      },
    );
  }
}
