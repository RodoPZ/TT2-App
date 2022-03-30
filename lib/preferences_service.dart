import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt2/models.dart';

class PreferencesService{
  Future saveUser(UserData userData) async{
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString("nombreUsuario", userData.nombreUsuario);
    await preferences.setString("apellidoUsuario", userData.apellidoUsuario);
    await preferences.setString("correo", userData.correo);
    await preferences.setString("contraseña", userData.password);
    await preferences.setBool("esPaciente", userData.esPaciente);
  }
  Future savePastilla(Pastilla pastilla) async{
    // List pastillasData = [[pastilla.pastillaNombre,pastilla.pastillaCantidad,pastilla.pastillaCaducidad]];
    final preferences = await SharedPreferences.getInstance();
    List pastillasData = jsonDecode(preferences.getString('pastillasData')!);
    if (preferences.containsKey('pastillasData')) {
      if (pastillasData.length < 10) {
        pastillasData.add([
          pastilla.pastillaNombre,
          pastilla.pastillaCantidad,
          pastilla.pastillaCaducidad]);
        await preferences.setString("pastillasData", jsonEncode(pastillasData));
        print(jsonDecode(preferences.getString("pastillasData")!));
      }
      else {
        print("Lista llena");
      }
    }
    else{
      List pastillasData = [[pastilla.pastillaNombre,pastilla.pastillaCantidad,pastilla.pastillaCaducidad]];

      await preferences.setString("pastillasData",jsonEncode(pastillasData));
    }
  }
  Future saveHorario(Horario horario) async{
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('horariosData')){

      List horarioData = jsonDecode(preferences.getString('horariosData')!);

      if (horarioData.length < 1){
        horarioData.add([
          horario.horarioHora,
          horario.horarioRepetir]);

        await preferences.setString("horariosData", jsonEncode(horarioData));
        print(jsonDecode(preferences.getString("horariosData")!));
      }
      else{
        print("Lista llena");
      }
    }
    else{
      List horarioData = [[horario.horarioHora,horario.horarioRepetir]];

      await preferences.setString("horariosData",jsonEncode(horarioData));
    }
  }
  Future saveContacto(Contacto contacto) async{
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('contactosData')){

      List contactosData = jsonDecode(preferences.getString('contactosData')!);

      if (contactosData.length < 20){
        contactosData.add([
          contacto.contactoNombre,
          contacto.contactoNumero]);

        await preferences.setString("contactosData", jsonEncode(contactosData));
        print(jsonDecode(preferences.getString("contactosData")!));
      }
      else{
        print("Lista llena");
      }
    }
    else{
      List contactosData = [[contacto.contactoNombre,contacto.contactoNumero]];
      await preferences.setString("contactosData",jsonEncode(contactosData));
    }
  }

  Future savePin(Pin pin) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("pinData", pin.pin);
  }

  Future deleteContacto(int index) async{
    final preferences = await SharedPreferences.getInstance();
    List contactosData = jsonDecode(preferences.getString('contactosData')!);
    contactosData.removeAt(index);
    await preferences.setString("contactosData", jsonEncode(contactosData));
  }
  Future deletePastilla(int index) async{
    final preferences = await SharedPreferences.getInstance();
    List pastillasData = jsonDecode(preferences.getString('pastillasData')!);
    pastillasData.removeAt(index);
    await preferences.setString("pastillasData", jsonEncode(pastillasData));
  }
  Future deleteHorario(int index) async{
    final preferences = await SharedPreferences.getInstance();
    List horarioData = jsonDecode(preferences.getString('horariosData')!);
    horarioData.removeAt(index);
    await preferences.setString("horariosData", jsonEncode(horarioData));
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

    final preferences = await SharedPreferences.getInstance();
    List pastillasData = jsonDecode(preferences.getString('pastillasData')!);

    return pastillasData;
  }
  Future getHorario() async{

    final preferences = await SharedPreferences.getInstance();
    List horariosData = jsonDecode(preferences.getString('horariosData')!);

    return horariosData;
  }
  Future getContacto() async{
    List contactosData = [];
    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('contactosData')){
      contactosData = jsonDecode(preferences.getString('contactosData')!);
    }
    print(contactosData);
    return contactosData;
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