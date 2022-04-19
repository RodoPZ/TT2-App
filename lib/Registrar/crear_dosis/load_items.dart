import 'package:flutter/material.dart';
import 'package:tt2/preferences_service.dart';

import '../../Components/button_icon.dart';
import '../../Components/button_main.dart';

class LoadItems extends StatefulWidget {
  final Future<dynamic> Function() getter;
  final IconData icono;
  final Function(List) getData;
  final int intSelection;


  const LoadItems(
      {
      this.intSelection = 1,   // 0 = selector de pastillas, 1 = solo clic, 2 = alarmas,
      required this.getter,
      required this.icono,
      required this.getData,
      Key? key})
      : super(key: key);

  @override
  _LoadItems createState() => _LoadItems();
}

class _LoadItems extends State<LoadItems> {
  late List<bool> _selected;
  late List<int> _count;
  late List<int> _quantity;
  List items = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    items = await widget.getter();
    setState(() {
      _selected = List.generate(items.length, (index) => false);
      _count = List.generate(items.length, (index) => 0);
      if(widget.intSelection == 0){
        _quantity = List.generate(items.length, (index) => items[index]["cantidad"]);
      }
    });
  }
 //En caso de que se tengan que seleccionar cantidad de pastillas
  Widget Selector(index){
   if(widget.intSelection == 0){
     return Row(
       children: [
         ButtonIcon( icon: Icons.add,
             color: Theme.of(context).primaryColor,
             callBack: () {
               if(_count[index]<_quantity[index]){
                 setState(() {
                   _count[index]++;
                 });
               }
             }
         ),
         Text(_count[index].toString()),
         ButtonIcon(
             icon: Icons.remove,
             color: Theme.of(context).primaryColor,
             callBack: () {
               if(_count[index]>0){
                 setState(() {
                   _count[index]--;
                 });
               }
             }
         ),
       ],
     );
   }else{
     return SizedBox();
   }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.75,
          height: MediaQuery.of(context).size.height*0.5,
          child: ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Flexible(
                      child: ListTile(
                        selected: _selected[index] ? true : false,
                        selectedColor: Theme.of(context).primaryColor,
                        title: Text(
                          items[index].values.elementAt(1),
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(items[index].values.elementAt(2).toString(),style: const TextStyle(fontSize: 15)),
                        onTap: (){
                          if(widget.intSelection == 1){
                            setState(() {
                              _selected[index] = !_selected[index];
                            });
                          }
                        },
                      ),
                    ),
                    Selector(index),
                  ],
                );
              }),
        ),
        ButtonMain(
            buttonText: "Seleccionar",
            callback: () {
              List _data = [];

              if(widget.intSelection == 0){              //Selector de pastillas
                for (int i = 0; i < _count.length; i++) {
                  if (_count[i] != 0) {
                    _data.add([items[i]["id"],_count[i]]);
                  }
                }
              } else if(widget.intSelection == 1) {              //Selector al hacer clic
                for (int i = 0; i < _selected.length; i++) {
                  if(_selected[i] == true){
                    _data.add([items[i]["id"],items[i].values.elementAt(2)]);
                  }
                }
              }
              setState(() {
                widget.getData(_data);
              });

              _getItems();
              Navigator.pop(context);
            })
      ],
    );
  }
}
