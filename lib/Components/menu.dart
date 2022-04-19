import 'package:flutter/material.dart';
import 'package:tt2/Registrar/registrar_main.dart';
import 'package:tt2/homepage/homepage_main.dart';
import 'package:tt2/Dosis_registradas/dosis_registradas_main.dart';

class Menu extends StatefulWidget{
  String userName = "UserName";
  String currentSection = "Inicio";
  Menu(this.userName, this.currentSection, {Key? key}) : super(key: key);
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: Column(
          // Important: Remove any padding from the ListView.
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(
                  bottom: 100
              ),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi1pUfwsswzFZlvvooBCWR5tT1tdGLfY2y7oex3YJ7ctK42DVSxsd6s27d7_0JRSEjlr8&usqp=CAU"),
                      radius: 50,
                    ),
                    Text(widget.userName,
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(child:
            Column(children: [
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.home, color: Theme
                        .of(context)
                        .primaryColor),
                    const SizedBox(width: 10),
                    const Text("Inicio",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF35424a)
                        )),
                    const Spacer(flex: 10),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  if ( widget.currentSection != "Inicio" ){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePageMain("Rodo"))
                    );
                  }
                }
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.app_registration, color: Theme
                        .of(context)
                        .primaryColor),
                    const SizedBox(width: 10),
                    const Text("Registrar",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF35424a)
                        )),
                    const Spacer(flex: 10),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  if ( widget.currentSection != "Registrar" ){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => RegistrarMain())
                    );
                  }
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.description_outlined, color: Theme
                        .of(context)
                        .primaryColor),
                    const SizedBox(width: 10),
                    const Text("Dosis registradas",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF35424a)
                        )),
                    const Spacer(flex: 10),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  if ( widget.currentSection != "Dosis registradas" ){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => DosisRegistradasMain())
                    );
                  }
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.info_outline, color: Theme
                        .of(context)
                        .primaryColor),
                    const SizedBox(width: 10),
                    const Text("Información",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF35424a)
                        )),
                    const Spacer(flex: 10),
                    const Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ])
            ),

            ListTile(
              title: Row(
                children: [
                  Icon(Icons.settings, color: Theme
                      .of(context)
                      .primaryColor),
                  const Spacer(),
                  const Text("Configuración",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF35424a)
                      )),
                  const Spacer(flex: 10),
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}