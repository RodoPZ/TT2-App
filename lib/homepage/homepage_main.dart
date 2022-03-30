import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/homepage/estado_actual.dart';
import 'package:tt2/homepage/estado_pastillas.dart';
import 'package:tt2/homepage/dosis_proxima_lista.dart';
import 'historial_list.dart';


class HomePageMain extends StatelessWidget {
  String userName = "UserName";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePageMain(this.userName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo","Inicio"),
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi1pUfwsswzFZlvvooBCWR5tT1tdGLfY2y7oex3YJ7ctK42DVSxsd6s27d7_0JRSEjlr8&usqp=CAU"),
                        radius: 50,
                      ),
                    ),
                    Text(userName,
                        style: const TextStyle(
                          fontSize: 20,
                        )
                    ),
                    SizedBox(height: 30),
                    const Divider(thickness: 2),
                    Text("Estado actual",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    EstadoActual(),
                    const Divider(thickness: 2),
                    Text("Estado de pastillas",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    EstadoPastillas(),
                    const Divider(thickness: 2),
                    Text("Dosis Próximas",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    DosisProximaLista(),
                    const Divider(thickness: 2),
                    Text("Historial",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                    HistorialList(),
                  ],
                ),
              ],
            ),
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