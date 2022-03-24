import 'package:flutter/material.dart';
import 'package:tt2/Components/button_text.dart';

class PopUpDays extends StatelessWidget{
  Function(String?)? onChange;
  PopUpDays(this.onChange, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container(width: 150,child: ButtonText("Lunes", 0xff000000, 20, (){onChange!("Lunes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Martes", 0xff000000, 20, (){onChange!("Martes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Miercoles", 0xff000000, 20, (){onChange!("Miercoles");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Jueves", 0xff000000, 20, (){onChange!("Jueves");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Viernes", 0xff000000, 20, (){onChange!("Viernes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Sabado", 0xff000000, 20, (){onChange!("Sabado");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Domingo", 0xff000000, 20, (){onChange!("Domingo");Navigator.pop(context);})),
      ],
    );
  }
}