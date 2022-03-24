import 'package:flutter/material.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/button_text.dart';
import 'package:tt2/User_Register/user_register_main.dart';
import 'package:tt2/homepage/homepage_main.dart';
class LoginMain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: NetworkImage("https://www.adaptivewfs.com/wp-content/uploads/2020/07/logo-placeholder-image.png"),
                width:200,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Acceso",
                    style: TextStyle(
                      color: Color(0xFF35424a),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("¡Hola! Bienvenido",
                    style: TextStyle(
                      color: Color(0xFF989eb1),
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  InputText(inputText: "Email", inputHintText: "example@email.com"),
                  SizedBox(height: 10),
                  InputText(inputText: "Contraseña", inputHintText: "*******"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
                right: 30
              ),
              child: ButtonMain(buttonText: "Ingresar",callback: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => HomePageMain("Rodo")),
                );
              }),
            ),

             Center(
              child: ButtonText("Recuperar contraseña",0xFF989eb1,20,(){}),
            ),
            const SizedBox(height: 20),
            Center(
              child: ButtonText("¿No tienes cuenta con nosotros?",0xFFf85f6a,20,(){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => RegisterMain()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}