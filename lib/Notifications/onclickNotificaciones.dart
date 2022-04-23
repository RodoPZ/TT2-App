import 'package:flutter/material.dart';

class OnClickNotificaciones extends StatelessWidget {
  final String? payload;

  const OnClickNotificaciones({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            children: [
            Text(payload ?? ""),
        ],
      ),
    ),);
  }
}