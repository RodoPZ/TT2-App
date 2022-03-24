import 'package:flutter/material.dart';
import 'button_main.dart';


class TimePickers extends StatefulWidget{
  Function(String?)? onChange;
  TimePickers(this.onChange, {Key? key}) : super(key: key);
  @override
  _TimePickers createState() => _TimePickers();
}

class _TimePickers extends State<TimePickers>{
  TimeOfDay? time;
  String getText(){
    if(time==null){
      return 'Seleccionar hora';
    }else{
      final hours = time?.hour.toString().padLeft(2,'0');
      final minutes = time?.minute.toString().padLeft(2,'0');
      return '${hours}:${minutes}';
    }

  }
  @override
  Widget build(BuildContext context) => ButtonMain(
    buttonText: getText(),
    callback: () => pickTime(context),
    color: const Color(0xFF929292),
  );

  Future pickTime(BuildContext context) async{
    const initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(context: context,
      initialTime: time ?? initialTime,
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
    if (newTime == null) return;
    setState(() => time = newTime);
    widget.onChange!("${time?.hour.toString().padLeft(2,'0')}:${time?.minute.toString().padLeft(2,'0')}");
  }
}