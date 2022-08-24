import 'package:flutter/material.dart';
import 'package:tt2/Components/menu.dart';

class Avisos extends StatefulWidget {
  @override
  State<Avisos> createState() => _AvisosState();
}

class _AvisosState extends State<Avisos> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo", ""),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
      Container(
      margin: const EdgeInsets.only(
      top: 15,
        right: 20,
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services,
                size: 80,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              const Text(
                "Avisos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )
            ],
          ),
          const Divider(thickness: 2),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              right: 50,
              left: 50,
              bottom: 10,
            ),
            width: double.infinity,
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
                    color: Theme
                        .of(context)
                        .primaryColor, size: 40),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
