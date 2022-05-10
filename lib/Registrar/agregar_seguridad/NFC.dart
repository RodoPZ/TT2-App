import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tt2/Components/input_text.dart';
import 'package:tt2/Components/item_manager.dart';
import 'package:tt2/Components/button_main.dart';
import 'package:tt2/SaveRead.dart';
import 'package:tt2/models.dart';
import '../../SaveRead.dart';

class NFC extends StatefulWidget{
  @override
  State<NFC> createState() => _NFCState();
}

class _NFCState extends State<NFC> {
  final _readWrite = SaveRead();
  bool valuefirst = false;
  bool _isEmpty = true;

  Widget onAndroid(){
    return const Text("¡¡¡Solo pueden registrarse tarjetas NFC usando la interfaz del dispensador!!!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget onWeb(){
    late String _nfcNombre;
    late String _uid = "";
    late bool _isAdmin = false;

    Widget _buildNfcNombre() {
      return InputText(
        inputHintText: "Nombre de la dosis",
        inputmax: 20,
        textSize: 16,
        myValidator: (value) {
          if (value == null || value.isEmpty) {
            return "Se necesita un nombre";
          }
          return null;
        },
        myOnSave: (String? value) {
          _nfcNombre = value!;
        },
      );
    }

    Widget _buildIsAdmin() {
      return StatefulBuilder(builder: (context, setState) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Theme.of(context).primaryColor,
          secondary:
          Icon(Icons.admin_panel_settings, color: Theme.of(context).primaryColor),
          title: const Text(
            'Es Administrador',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          value: valuefirst,
          onChanged: (bool? newValue) {
            setState(() => valuefirst = newValue!);
          },
        );
      }
      );
    }
    
    Widget _buildUid(){

      Widget _errorText() {
        if (_isEmpty == true) {
          return const Text(
            "No puede estar vacío",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.red,
            ),
          );
        } else {
          return const SizedBox();
        }
      }

      return Column(
        children: [
          const Text("Presione el botón de \"registrar tarjetas\" e inmediatamente pase la tarjeta o pulsera que quiere registrar por encima del módulo NFC ubicado frente la carcasa",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ButtonMain(buttonText: "Registrar Tarjeta",
              callback: (){
                setState(()=> _isEmpty = false);
              }
          ),
          _errorText(),
        ],
      );
    }

    Widget formItems(){
      return Column(
        children: [
          _buildNfcNombre(),
          _buildIsAdmin(),
          SizedBox(height: 20),
          _buildUid(),
        ],
      );
    }
    _registerNfc() async {
      final newNfc =
        Nfc(uid: _uid, isAdmin: _isAdmin, nfcNombre: _nfcNombre);
      await _readWrite.saveNfc(newNfc);
    }

    return Column(
      children: [
        ItemManager(
            dataSubTitle: const ["uid"],
            dataTitle: "nombre",
            callback: () async {
              if (_nfcNombre != "" && _uid != "") {
                await _registerNfc();

                const snackBar = SnackBar(
                  content:
                  Text('Información de pastillas guardada!'),
                );
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
                setState(() {
                  _nfcNombre = "";
                  _uid = "";
                });
              }else{
                return;
              }
            },
            getter: _readWrite.getNfc,
            deleter: _readWrite.deleteNfc,
            form_items: formItems,
            register: _registerNfc,
            icono: Icons.nfc,
            title: "NFC",
            formTitle: "Registrar NFC"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 50),
      if(kIsWeb) onWeb() else if(Platform.isAndroid) onAndroid(),
    ]);
  }
}