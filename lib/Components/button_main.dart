import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget{
  String buttonText = "Text";
  VoidCallback callback;
  IconData ?icono;
  Color color;

  ButtonMain({required this.buttonText, required this.callback, this.icono, this.color = const Color(0xFFf85f6a), Key? key}) : super(key: key);

  Widget _widgetIcono(){
    if (icono != null){
      return Row(
        children: [
          Icon(icono,
            size: 25,
          ),
          const SizedBox(width: 20),
        ],
      );
    }else{
      return const SizedBox(width: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _widgetIcono(),
            Text(buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}