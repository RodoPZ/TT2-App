import 'package:flutter/material.dart';
import 'package:tt2/SaveRead.dart';

class EstadoActual extends StatefulWidget{
  EstadoActual( {Key? key}) : super(key: key);

  @override
  State<EstadoActual> createState() => _EstadoActualState();
}

class _EstadoActualState extends State<EstadoActual> {
  List<String> pillName = ["Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla"];

  bool loaded = false;
  final _readWrite = SaveRead();
  List _pastillasList = [];
  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    setState(() {
      loaded = false;
    });
    _pastillasList = await _readWrite.getPastilla();
    for (var i in _pastillasList){
      pillName[i["contenedor"]-1] = i["nombre"];
    }
    setState(() {
      loaded = true;
    });
  }
  buildPillColor(number){
    for (var i in _pastillasList){
      if(i["contenedor"] == number){
        if(i["cantidad"] > 10) return 0xFF7bff37;
        else if(i["cantidad"] >= 6 && i["cantidad"] <= 10) return 0xFFffc842;
        else if(i["cantidad"] <= 6) return 0xFFff0000;
      }
    }
    return 0xFF777777;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2,
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Contenedores",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0844a4),
                  ),
                ),
                for(var i = 1; i<= 10; i++)
                  Row(
                    children: [
                      Text(
                        "| "+i.toString() + " |",
                        style: TextStyle(fontSize: 16,
                          backgroundColor:  Color(buildPillColor(i)),
                        ),
                      ),
                      Text(
                        " " + pillName[i-1],
                        style: const TextStyle(fontSize: 16,
                        ),
                      ),
                    ],
                  )

              ],
            ),
          ),
          SizedBox(width: 50),
          Container(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width:15,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFF7bff37),
                              ),
                            ),
                          ),
                          Text(" Mayor a 10",style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: const [
                          SizedBox(width: 15,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFFffc842),
                              ),
                            ),
                          ),
                          Text(" Entre 6 y 10",style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: const [
                          SizedBox(width: 15,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFFff0000),
                              ),
                            ),
                          ),
                          Text(" Menor a 6",style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: const [
                          SizedBox(width: 15,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFF777777),
                              ),
                            ),
                          ),
                          Text(" Vacío",style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}