import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Registrar/agregar_notificaciones/contactos_main.dart';
import 'package:tt2/Registrar/agregar_notificaciones/dropdownmenu_notificaciones.dart';
import 'package:tt2/Registrar/registrar_main.dart';
import 'package:tt2/Components/input_text.dart';

class AgregarNotificacionesMain extends StatefulWidget{
  @override
  _AgregarNotificacionesMain createState() => _AgregarNotificacionesMain();
}

class _AgregarNotificacionesMain extends State<AgregarNotificacionesMain>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  checkpermission_contacts() async{

      var contactStatus = await Permission.contacts.status;
      print(contactStatus);

      if (!contactStatus.isGranted) {
        await Permission.contacts.request();
      }

      if(await Permission.contacts.isGranted){
        ContactosMain();
      }else{
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo",""),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Text("Agregar Notificaciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Tipo: ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        ),
                        DropDownMenuNotificaciones(value: (value) async {
                          if(value == "SMS"){
                            checkpermission_contacts();
                          }
                        },
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    // ContactosMain(),
                    const Divider(thickness: 2),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Texto: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                              width: 250,
                              child: InputText( inputHintText: "Es hora de tomar su medicina...")
                          ),
                        ],
                    ),
                    ),

                    const SizedBox(height: 30),
                    ButtonMain(buttonText: "Registrar", callback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => RegistrarMain()),
                      );
                    }),
                    

                  ],
                ),
              ),

            ],
          ),
          Positioned(
            left: 10,
            top: 20,
            child: Container(
              color: Colors.white,
              height: 55,
              width: 55,
              child: IconButton(
                icon: Icon(Icons.menu_sharp,
                    color: Theme.of(context).primaryColor,
                    size: 40),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
