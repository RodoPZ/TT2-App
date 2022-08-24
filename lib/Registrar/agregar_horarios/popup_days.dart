import 'package:flutter/material.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:collection/collection.dart';

class PopUpDays extends StatefulWidget {
  Function(dynamic)? onChange;

  PopUpDays(this.onChange, {Key? key}) : super(key: key);

  @override
  State<PopUpDays> createState() => _PopUpDaysState();
}

class _PopUpDaysState extends State<PopUpDays> {
  List<String> days = [
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
    "Sabado",
    "Domingo"
  ];
  late List checkBoxesCheckedStates =
  List<bool>.generate(days.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              height: 400,
              child: ListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(days[index]),
                      value: checkBoxesCheckedStates[index],
                      onChanged: (bool? newValue) {
                        setState(() {
                          checkBoxesCheckedStates[index] = newValue!;
                        });
                      },
                    );
                  }),
            ),
            ButtonMain(buttonText: "Registrar", callback: () {
                Function eq = const ListEquality().equals;
                if(checkBoxesCheckedStates.every((element) => element == false)){
                  return;
                }else if(checkBoxesCheckedStates.every((element) => element == true)){
                  widget.onChange!("Diariamente");
                }else if( eq(checkBoxesCheckedStates, [true, true, true, true, true, false, false])){
                  widget.onChange!("Lun a Vie");
                }else{
                  List days = ['Lu','Ma','Mi','Ju','Vi','Sa','Do'];
                  List result = [];
                  for(int i = 0; i < days.length; i++){
                    if(checkBoxesCheckedStates[i] == true){
                      result.add(days[i]);
                    }
                  }
                  widget.onChange!(result);
                }
                Navigator.pop(context);
            }),
          ]
      );
  }
}
