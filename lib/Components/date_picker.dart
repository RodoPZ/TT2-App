import 'package:flutter/material.dart';
import 'button_main.dart';


class DatePicker extends StatefulWidget{
  Function(String?)?  onChange;
  DatePicker(this.onChange, {Key? key}) : super(key: key);
  @override
  _DatePicker createState() => _DatePicker();
}

class _DatePicker extends State<DatePicker>{
  DateTime? date;
  String getText(){
    if(date==null){
      return 'Seleccionar fecha';
    }else{
      return '${date?.day}/${date?.month}/${date?.year}';
    }

  }
  @override
  Widget build(BuildContext context) => ButtonMain(
    buttonText: getText(),
    callback: (){
      pickDate(context);
    },
    color: const Color(0xFF929292),
  );
  
  Future pickDate(BuildContext context) async{
   final initialDate = DateTime.now();
   final newDate = await showDatePicker(context: context,
       initialDate: date ?? initialDate,
       firstDate: DateTime(DateTime.now().year - 5),
       lastDate: DateTime(DateTime.now().year + 5),
       builder: (context, child) {
         return Theme(
           data: Theme.of(context).copyWith(
             colorScheme: ColorScheme.light(
               primary: Theme.of(context).primaryColor, // header background color
             ),
             textButtonTheme: TextButtonThemeData(
               style: TextButton.styleFrom(
                 primary: Colors.red, // button text color
               ),
             ),
           ),
           child: child!,
         );
       },
   );
   if (newDate == null) return;
   setState(() => date = newDate);
   widget.onChange!('${date?.day}/${date?.month}/${date?.year}');
  }
}