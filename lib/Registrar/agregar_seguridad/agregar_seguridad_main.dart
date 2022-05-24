import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';
import 'package:tt2/Registrar/agregar_seguridad/reconocimiento_facial.dart';
import 'package:tt2/Registrar/agregar_seguridad/PIN.dart';
import 'NFC.dart';

class AgregarSeguridadMain extends StatefulWidget{
  @override
  _AgregarSeguridadMain createState() => _AgregarSeguridadMain();
}

class _AgregarSeguridadMain extends State<AgregarSeguridadMain> with SingleTickerProviderStateMixin{
  TabController ?_controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        const Text("Agregar seguridad",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    const Divider(thickness: 2),
                    Container(
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                      child: TabBar(
                        controller: _controller,
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.face),
                            text: 'FACIAL',
                          ),
                          Tab(
                            icon: Icon(Icons.nfc),
                            text: 'NFC',
                          ),
                          Tab(
                            icon: Icon(Icons.pin),
                            text: 'PIN',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500.0,
                      child: TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          ReconocimientoFacial(),
                          NFC(),
                          PIN(),
                        ],
                      ),
                    ),
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
