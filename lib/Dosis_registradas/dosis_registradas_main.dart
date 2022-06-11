import 'package:flutter/material.dart';
import '../Components/menu.dart';
import 'createDataTable.dart';

class DosisRegistradasMain extends StatefulWidget {
  @override
  State<DosisRegistradasMain> createState() => _DosisRegistradasMainState();
}

class _DosisRegistradasMainState extends State<DosisRegistradasMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Menu("Rodo Pinedo", "Dosis registradas"),
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.paste,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Dosis registradas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Divider(thickness: 2),
                  Container(
                    child: CreateDataTable(),
                  ),

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
                    color: Theme.of(context).primaryColor, size: 40),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
