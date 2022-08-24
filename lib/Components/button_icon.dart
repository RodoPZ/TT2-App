import 'package:flutter/material.dart';

class ButtonIcon extends StatefulWidget{
  late VoidCallback callBack ;
  late String buttonText;
  late double size;
  late double iconSize;
  late Color color;
  late IconData icon;

  ButtonIcon({this.iconSize = 40,this.buttonText="",required this.icon,this.size = 0,required this.color,required this.callBack,Key? key}) : super(key: key);


  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {

  Widget buttonText(){
    if(widget.buttonText != ""){
      return Text(widget.buttonText,
        style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      );
    }else{
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size == 0? widget.iconSize : widget.size,
      width: widget.size == 0? widget.iconSize : widget.size,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(width: 0,color: Colors.transparent),
        ),
        onPressed: widget.callBack,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
                size: widget.iconSize,
              ),
            buttonText(),
          ],
        ),
      ),
    );
  }
}