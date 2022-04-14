import 'package:flutter/material.dart';
import 'package:tt2/Components/button_icon.dart';
import 'package:tt2/preferences_service.dart';
import 'load_items.dart';

class Section extends StatefulWidget{
  late String sectionName;
  late String firstColText;
  late String secondColText;
  late String formText;
  final Function(List) selected;
  final Function(List) data;
  final Future<dynamic> Function() getter;
  late int intSelection;

  Section({required this.data,this.intSelection = 0,required this.getter,required this.formText,required this.selected,required this.sectionName, required this.firstColText ,this.secondColText="",Key? key}) : super(key: key);

  @override
  _Section createState() => _Section();
}

class _Section extends State<Section>{
  List _itemsSelected = [];
  List _itemQuantity = [];
  List items = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async{
    items = await widget.getter();
  }
  Widget getElementsByID(index){
    List elements = [];
    for (var id in _itemsSelected) {
      for (var map in items) {
        if(map["id"]==id){
          elements.add(map.values.elementAt(1));
        }
      }
    }

    return Text(items[index].values.elementAt(1).toString());
  }
  
  Widget printItemsName(){
    return Column(
      children: [
        SizedBox(
          height: _itemsSelected.length*20,
          width: 100,
          child: GridView.count(
            childAspectRatio: 5,
              crossAxisCount: 1,
              children: List.generate(_itemsSelected.length, (index) {
                return Center(child: getElementsByID(index));
              }
              ),

              ),
        ),
      ],
    );
  }
  Widget printPastillasCantidad(){
    return Column(
      children: [
        SizedBox(
          height: _itemsSelected.length*20,
          width: 100,
          child: GridView.count(
            childAspectRatio: 5,
            crossAxisCount: 1,
            children: List.generate(_itemQuantity.length, (index) {
              return Center(child: Text(_itemQuantity[index].toString()));
            }
            ),

          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(widget.sectionName,
            style:  TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalDivider(thickness: 2),
          Column(
            children: [
              Text(widget.firstColText,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),
              printItemsName(),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(widget.secondColText,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),
              printPastillasCantidad(),
            ],
          ),
          const Spacer(),
          ButtonIcon(icon: Icons.add, size: 30,color: Theme.of(context).primaryColor, callBack: (){
            form();
          }),
        ],
      ),
    );
  }

  form() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.formText,
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                LoadItems(
                  intSelection: widget.intSelection,
                    icono: Icons.medication,
                    getter: widget.getter,
                    getData: (elements){
                      setState(() {
                        _itemsSelected = elements[0];
                        _itemQuantity = elements[1];
                      });
                    },
                ),
              ],
            ),
          );
        });
  }
}