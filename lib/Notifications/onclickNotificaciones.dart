import 'package:flutter/material.dart';
class OnClickNotificaciones extends StatelessWidget {
  final String? payload;
  const OnClickNotificaciones({Key? key, this.payload}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text("Es la hora de tomar su medicina!!!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
            Text("Diríjase al compartimento para recibir su dosis",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
        ],
      ),
    );
  }
}
