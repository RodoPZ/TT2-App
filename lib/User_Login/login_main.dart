import 'package:flutter/material.dart';
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/button_text.dart';
import 'package:tt2/User_Register/user_register_main.dart';
import 'package:tt2/homepage/homepage_main.dart';
import 'package:tt2/Notifications/onclickNotificaciones.dart';
import 'package:tt2/Notifications/notificationPlugin.dart';

class LoginMain extends StatefulWidget{
  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override

  late String _correo;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    NotificationPlugin.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationPlugin.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OnClickNotificaciones(payload: payload)));

  Widget _buildEmail(){
    return InputText(
      inputText: "Email:",
      inputHintText: "mail@gmail.com",
      inputmax: 40,
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita un Correo";
        }
        return null;
      },
      myOnSave: (String? value) {
        _correo = value!;
      },
    );
  }

  Widget _buildPassword(){
    return InputText(
      inputText: "Contraseña:",
      inputHintText: "********",
      textSize: 16,
      myValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Se necesita una contraseña";
        }
      },
      myOnSave: (String? value) {
        _password = value!;
      },
      isPassword: true,
    );
  }


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
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          _buildEmail(),
                          SizedBox(height: 10),
                          _buildPassword(),
                        ],
                      )),
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
                // if(!_formKey.currentState!.validate()){
                //   return;
                // }
                // _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => HomePageMain("Rodo")),
                );
              }),
            ),

             Center(
              child: ButtonText("Recuperar contraseña",Theme.of(context).primaryColor,20,(){ }),
            ),
            const SizedBox(height: 20),
            Center(
              child: ButtonText("¿No tienes cuenta con nosotros?",Theme.of(context).primaryColor,20,(){
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