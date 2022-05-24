import 'package:flutter/material.dart';
import 'package:tt2/Components/button_icon.dart';
import 'button_main.dart';

class ItemManager extends StatefulWidget {
  final String title;
  final String dataTitle;
  final List<String> dataSubTitle;
  final String formTitle;
  final Widget Function() form_items;
  final Function() register;
  final IconData icono;
  final Future<dynamic> Function() getter;
  final Future<dynamic> Function(String) deleter;
  final Function() callback;
  final String buttonText;

  const ItemManager({
    this.buttonText = "Registrar",
    required this.dataSubTitle,
    required this.dataTitle,
    required this.callback,
    required this.getter,
    required this.deleter,
    required this.form_items,
    required this.register,
    required this.icono,
    required this.title,
    required this.formTitle,
    Key? key}) : super(key: key);

  @override
  State<ItemManager> createState() => _ItemManagerState();
}

class _ItemManagerState extends State<ItemManager> {
  bool isFull = false;
  late List items = [];
  late List<bool> _selected;
  bool loaded = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    setState(() {
      loaded = false;
    });
    items = await widget.getter();
    setState(() {
      _selected = List.generate(items.length, (index) => false);
      loaded = true;
    });
    if (items.length == 10) {
      _showAlert(context);
      setState(() {
        isFull = true;
      });
    } else {
      setState(() {
        isFull = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 30,
              left: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ButtonIcon(
                    color: isFull
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    icon: Icons.add,
                    callBack: () {
                      if(isFull == false){
                        form();
                      }else{
                        _showAlert(context);
                      }
                    })
              ],
            ),
          ),
          printItems(),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Atención!"),
              content: const Text(
                "Los contenedores están llenos (10 pastillas registradas), no puede registrar nuevas pastillas hasta que elimine pastillas, pero puede abrir el compartimento.",
                textAlign: TextAlign.justify,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => Navigator.pop(context, 'ok'),
                      child: const Text('ok',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ));
  }

  Widget printItems() {
    if (loaded == true) {
      if (items.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                        child: ListTile(
                            selected: _selected[index] ? true : false,
                            selectedColor: Theme.of(context).primaryColor,
                            leading: Icon(widget.icono,color: Theme.of(context).primaryColor,size: 40),
                            title: Text(items[index][widget.dataTitle].toString()),
                            subtitle: Text(_printSubtitleDetails(index)),
                            trailing: ButtonIcon(
                                color: Theme.of(context).primaryColor,
                                icon: Icons.delete,
                                callBack: () async {
                                  setState(() => loaded = false);
                                  await widget.deleter(items[index]["serverid"]);
                                  _getItems();
                                }
                                ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text("No hay nada que mostrar",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        );
      }
    } else {
      return CircularProgressIndicator(color: Theme.of(context).primaryColor,);
    }
  }

  _printSubtitleDetails(index){
    late String subtitle = "";

    for(var data in widget.dataSubTitle){
      subtitle += items[index][data].toString() + "  |  ";
    }
    return subtitle;
  }

  form() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.formTitle,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      widget.form_items(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonMain(
                        buttonText: widget.buttonText,
                        color: Theme.of(context).primaryColor,
                        callback: () async{
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          await widget.callback();
                          _getItems();
                        }))
              ],
            ),
          );
        });
  }
}
