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
          Container(width: 150,child: ButtonText("Lunes", Theme.of(context).primaryColor, 20, (){onChange!("Lunes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Martes", Theme.of(context).primaryColor, 20, (){onChange!("Martes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Miercoles", Theme.of(context).primaryColor, 20, (){onChange!("Miercoles");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Jueves", Theme.of(context).primaryColor, 20, (){onChange!("Jueves");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Viernes", Theme.of(context).primaryColor, 20, (){onChange!("Viernes");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Sabado", Theme.of(context).primaryColor, 20, (){onChange!("Sabado");Navigator.pop(context);})),
          Container(width: 150,child: ButtonText("Domingo", Theme.of(context).primaryColor, 20, (){onChange!("Domingo");Navigator.pop(context);})),
      ],
    );
  }
}