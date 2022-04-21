import 'package:flutter/material.dart';
import 'package:tt2/Components/button_icon.dart';
import 'package:tt2/preferences_service.dart';

class GetDosis extends StatefulWidget{
  late String sectionName;
  late String firstColText;
  late String secondColText;
  late String formText;
  final Function(List) selected;
  final Future<dynamic> Function() getter;
  late int intSelection;

  GetDosis({this.intSelection = 0,required this.getter,required this.formText,required this.selected,required this.sectionName, required this.firstColText ,this.secondColText="",Key? key}) : super(key: key);

  @override
  _GetDosis createState() => _GetDosis();
}

class _GetDosis extends State<GetDosis>{
  final _preferencesService = PreferencesService();
  List _itemsSelected = [];
  List _itemQuantity = [];
  List items = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async{
    items = await _preferencesService.getDosis();
  }

  // Widget getElementsByID(index){
  //   List elements = [];
  //   for (var id in _itemsSelected) {
  //     for (var map in items) {
  //       if(map["id"]==id){
  //         elements.add(map.values.elementAt(1));
  //       }
  //     }
  //   }
  //
  //   return Text(items[index].values.elementAt(1).toString());
  // }

  // Widget printItemsName(){
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: _itemsSelected.length*20,
  //         width: 100,
  //         child: GridView.count(
  //           childAspectRatio: 5,
  //           crossAxisCount: 1,
  //           children: List.generate(_itemsSelected.length, (index) {
  //             return Center(child: getElementsByID(index));
  //           }
  //           ),
  //
  //         ),
  //       ),
  //     ],
  //   );
  // }
  // Widget printPastillasCantidad(){
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: _itemsSelected.length*20,
  //         width: 100,
  //         child: GridView.count(
  //           childAspectRatio: 5,
  //           crossAxisCount: 1,
  //           children: List.generate(_itemQuantity.length, (index) {
  //             return Center(child: Text(_itemQuantity[index].toString()));
  //           }
  //           ),
  //
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [


        ],
      ),
    );
  }
}