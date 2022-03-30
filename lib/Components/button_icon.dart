import 'package:flutter/material.dart';

class ButtonIcon extends StatefulWidget{
  late VoidCallback callBack ;
  late double size;
  IconData icon;

  ButtonIcon({required this.icon,this.size = 20,required this.callBack,Key? key}) : super(key: key);


  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.size,
      color: Theme.of(context).primaryColor,
      icon: Icon(widget.icon),
      onPressed: widget.callBack,
    );
  }
}