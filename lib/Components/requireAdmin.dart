import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/SaveRead.dart';

final _readWrite = SaveRead();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
late String _pin;

Widget _buildPin(pinData,context) {
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
        else if(pinData["pinData"] != value){
          return "Contraseña incorrecta";
        }

      },
      onSaved: (value){
        _pin = value!;
      },
      onChanged: (String) {});
}

RequireAdmin(context, Function() AdminNeeded,Function() NoAdmin) async {
  Map pinData = await _readWrite.getPin();
  if(pinData["admin"] == true){
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
                      children: [
                        _buildPin(pinData ,context),
                      ],
                    )
                ),
                const Text("Favor de ingresar su PIN de administrador",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                SizedBox(height: 30),
                ButtonMain(buttonText: "Aceptar", callback: () async{
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  pinData = await _readWrite.getPin();
                  if(pinData["pinData"] == _pin){
                    AdminNeeded();
                  }
                })
              ],
            ),
          );
        });
  }else{
    NoAdmin();
  }
}
