import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt2/models.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';

class SaveRead{
  Future saveUser(UserData userData) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("nombreUsuario", userData.nombreUsuario);
    await preferences.setString("apellidoUsuario", userData.apellidoUsuario);
    await preferences.setString("correo", userData.correo);
    await preferences.setString("contraseña", userData.password);
    await preferences.setBool("esPaciente", userData.esPaciente);
  }

  savePastilla(Pastilla pastilla) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    int pastillasData = querySnapshot.docs.length;
      if (pastillasData < 10){
        collection.add({
            "nombre":pastilla.pastillaNombre,
            "cantidad":pastilla.pastillaCantidad,
            "caducidad":pastilla.pastillaCaducidad,
          }).then((value) => print("User Added"));
      }
  }

  Future saveHorario(Horario horario) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/');
    var querySnapshot = await collection.get();
    int horariosData = querySnapshot.docs.length;
    if (horariosData < 100){
      collection.add({
        "hora":horario.horarioHora,
        "repetir":horario.horarioRepetir
      }).then((value) => print("User Added"));
    }
  }

  Future saveContacto(Contacto contacto) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Contactos/');
    var querySnapshot = await collection.get();
    int contactosData = querySnapshot.docs.length;
    if (contactosData < 100){
      collection.add({
        "nombre": contacto.contactoNombre,
        "numero": contacto.contactoNumero
      }).then((value) => print("User Added"));
    }
  }

  Future saveDosis(Dosis dosis, Function(int) callback) async{
    final List <int>_id = [];
    int _newid = 0;
    //Asignar una id única

    final preferences = await SharedPreferences.getInstance();
    // preferences.remove("dosisData");
    if (preferences.containsKey('dosisData')){
      List dosisData = jsonDecode(preferences.getString('dosisData')!);
      if (dosisData.isNotEmpty){
        for (var value in dosisData) {
          _id.add(value['id']);
        }
        for(int i = 0; i <= _id.reduce(max); i++){
          if(_id.contains(i) == false && _id.last != i){
            _newid = i;
            break;
          }
          _newid = _id.reduce(max)+1;
        }
      }
      if (dosisData.length < 20){
        dosisData.add({
          "id": _newid,
          "nombre": dosis.dosisNombre,
          "pastillas": dosis.pastillaData,
          "horario": dosis.horarioData,
          "alarmas": dosis.alarmaData,
          "seguridad": dosis.seguridadData,
        });
        print(dosisData);
        await preferences.setString("dosisData", jsonEncode(dosisData));
      }
      callback(_newid);
    }
    else{
      List dosisData = [{'id':0,'nombre':dosis.dosisNombre,'pastillas':dosis.pastillaData,'horario':dosis.horarioData,"alarmas": dosis.alarmaData,"seguridad": dosis.seguridadData}];
      await preferences.setString("dosisData",jsonEncode(dosisData));
      callback(0);
    }

  }

  Future savePin(Pin pin) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("pinData", pin.pin);
  }

  Future deleteContacto(int index) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Contactos/');
    var querySnapshot = await collection.get();
    String id = querySnapshot.docs[index].reference.id;
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deletePastilla(int index) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    String id = querySnapshot.docs[index].reference.id;
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteHorario(int index) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/');
    var querySnapshot = await collection.get();
    String id = querySnapshot.docs[index].reference.id;
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteDosis(int index) async{
    final preferences = await SharedPreferences.getInstance();
    List dosisData = jsonDecode(preferences.getString('dosisData')!);
    dosisData.removeAt(index);
    preferences.setString("dosisData", jsonEncode(dosisData));
  }

  Future deletePin() async{
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("pinData");
  }

  Future getUserData() async{
    final preferences = await SharedPreferences.getInstance();

    final String? nombreUsuario = preferences.getString("nombreUsuario");
    final String? apellidoUsuario = preferences.getString("apellidoUsuario");
    final String? correo =  preferences.getString("correo");
    final String? password =  preferences.getString("contraseña");
    final bool? esPaciente =  preferences.getBool("esPaciente");

    return UserData(nombreUsuario: nombreUsuario!, apellidoUsuario: apellidoUsuario!, correo: correo!, password: password!, esPaciente: esPaciente!);
  }

  Future getPastilla() async{
    List pastillasData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      pastillasData.add(data);
    }
    return pastillasData;
  }

  Future getHorario() async{
    List horariosData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      horariosData.add(data);
    }
    return horariosData;
  }

  Future getContacto() async{
    List contactosData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Contactos');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      contactosData.add(data);
    }
    return contactosData;
  }

  Future getDosis() async{
    List dosisData = [];
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('dosisData')){
      dosisData = jsonDecode(preferences.getString('dosisData')!);
    }
    return dosisData;
  }

  Future getPin() async {
    late String pinData = "";
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('pinData')){
      pinData = preferences.getString('pinData')!;
    }
    return pinData;
  }
}