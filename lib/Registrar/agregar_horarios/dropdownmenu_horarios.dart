import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Registrar/agregar_horarios/popup_days.dart';

class DropDownMenuHorarios extends StatefulWidget {
  Function(dynamic)? onChange;

  DropDownMenuHorarios(this.onChange, {Key? key}) : super(key: key);

  @override
  _DropDownMenuHorarios createState() => _DropDownMenuHorarios();
}

class _DropDownMenuHorarios extends State<DropDownMenuHorarios> {
  // Initial Selected Value
  String dropdownvalue = 'Seleccionar';

  // List of items in our dropdown menu
  var items = [
    'Seleccionar',
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
        if (newValue == "Personalizado") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  title: const Text('Elegir un día'),
                  content: PopUpDays((value) {
                    setState(() {
                      if (value == "Diariamente") {
                        print(value);
                        setState(() => dropdownvalue == "Diariamente");
                        widget.onChange!("Diariamente");
                      } else if (value == "Una vez") {
                        print(value);
                        setState(() => dropdownvalue == "Una vez");
                        widget.onChange!("Una vez");
                      } else {
                        print(value);
                        widget.onChange!(value);
                      }
                    });
                  }),
                ),
          );
        }else{
          setState(() {
            dropdownvalue = newValue!;
          });
        }

        widget.onChange!(dropdownvalue);
      },
    );
  }
}
