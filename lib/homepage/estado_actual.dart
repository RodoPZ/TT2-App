import 'package:flutter/material.dart';

class EstadoActual extends StatelessWidget{
  List<String> pillName = ["Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla","Sin pastilla"];

  EstadoActual( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                SizedBox(height: 76,),
                Text("1 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
                Text("2 | "+ pillName[1],style: const TextStyle(fontSize: 16)),
                Text("3 | "+ pillName[2],style: const TextStyle(fontSize: 16)),
                Text("4 | "+ pillName[3],style: const TextStyle(fontSize: 16)),
                Text("5 | "+ pillName[4],style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(width: 50),
          Container(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Suministro",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF0844a4),
                  ),
                ),
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
                          Text(" Mayor a 66%",style: const TextStyle(fontSize: 16)),
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
                          Text(" Entre 33% y 66%",style: const TextStyle(fontSize: 16)),
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
                          Text(" Menor a 33%",style: const TextStyle(fontSize: 16)),
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
                          Text(" Compartimiento vacío",style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text("6 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
                Text("7 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
                Text("8 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
                Text("9 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
                Text("10 | "+ pillName[0],style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}