import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Registrar/button_icon.dart';
import 'package:tt2/Registrar/agregar_pastillas/agregar_pastillas_main.dart';
import 'package:tt2/Registrar/agregar_horarios/agregar_horarios_main.dart';
import 'package:tt2/Registrar/agregar_notificaciones/agregar_contactos_main.dart';
import 'package:tt2/Registrar/agregar_seguridad/agregar_seguridad_main.dart';
import 'package:tt2/Registrar/crear_dosis/crear_dosis_main.dart';

class RegistrarMain extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo","Registrar"),
      body: Stack(
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Icon(Icons.description_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 70,
                  ),
                  const Text("Registrar",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  )),
                  const Divider(thickness: 2,),
                  Container(
                    height: 270,
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            ButtonIcon(Icons.medical_services_outlined,"Pastillas",(){
                              Navigator.push(
                                context,
                                //MaterialPageRoute(builder: (builder) => AgregarPastillasMain()),
                                MaterialPageRoute(builder: (builder) => AgregarPastillasMain()),
                              );
                            }),
                            const Spacer(),
                            ButtonIcon(Icons.access_alarm,"Horarios",(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (builder) => AgregarHorariosMain()),
                              );
                            }),
                            const Spacer(),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Spacer(),
                            ButtonIcon(Icons.person_add,"Contactos",(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (builder) => AgregarContactosMain()),
                              );
                            }),
                            const Spacer(),
                            ButtonIcon(Icons.security,"Seguridad",(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (builder) => AgregarSeguridadMain()),
                              );
                            }),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text("Crear Dosis",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  ButtonIcon(Icons.paste,"Dosis",(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => CrearDosisMain()),
                    );
                  }),
                ],
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