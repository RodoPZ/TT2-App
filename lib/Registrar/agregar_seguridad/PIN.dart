import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/models.dart';
import '../../SaveRead.dart';
import 'package:tt2/Components/button_text.dart';

class PIN extends StatefulWidget{
  @override
  State<PIN> createState() => _PINState();
}

class _PINState extends State<PIN> {
  final _preferencesService = SaveRead();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String items = "";
  late String _pin;
  bool isConfigured = false;
  bool justConfigured = false;

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  _getItems() async {
    items = await _preferencesService.getPin();
    if (items == "" || items.isEmpty){
      setState(() {
        isConfigured = false;
      });
    }
    else{
      setState(() {
        isConfigured = true;
      });
    }
  }
  _changeWidget(){
    setState(() {
      justConfigured = true;
    });
  }


  Widget _buildPin() {
    return PinCodeTextField(
        appContext: context,
        length: 4,
        cursorColor: Theme.of(context).primaryColor,
        autovalidateMode: AutovalidateMode.disabled,
        errorTextSpace: 20,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
          // Using for Text Only ==>    (RegExp(r'[a-zA-Z]'))
        ],
        pinTheme: PinTheme(
          activeColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
        ),
        validator: (value) {
          if (value?.length != 4) {
            return "Faltan datos";
          }
        },
        onSaved: (String){
          _pin = String!;
        },
        onChanged: (String) {});
  }

  Widget _alreadyConfigured() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("Ya hay un PIN registrado",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold)),
        ButtonText("¿Olvidó su PIN?", Theme.of(context).primaryColor, 20, (){}),
        ButtonText("Cambiar PIN", Theme.of(context).primaryColor, 20, (){
          setState(() {
            isConfigured = false;
          });
        })
      ],
    );
  }
  Widget _justConfigured() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text("PIN registrado con éxito!!!",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isConfigured == true){
      return _alreadyConfigured();
    }else if (justConfigured == true){
      return _justConfigured();
    }
    else{
      return Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              const Text("Elegir un pin de 4 letras",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: _buildPin(),
              ),
              SizedBox(height: 30),
              ButtonMain(buttonText: "Registrar", callback: (){
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                if (isConfigured == false){
                  _formKey.currentState!.save();
                  _registerPin();
                  _changeWidget();
                }else{
                }
              })
            ],

          ),
        ),
      );
    }
  }

  _registerPin() {
    final newPin = Pin(pin: _pin);
    _preferencesService.savePin(newPin);
  }
}