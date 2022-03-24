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
    // List pastillasData = [[pastilla.pastillaNombre,pastilla.pastillaCantidad,pastilla.pastillaCaducidad]];
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('horariosData')){

      List horarioData = jsonDecode(preferences.getString('horariosData')!);

      if (horarioData.length < 100){
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

  Future<UserData> getUserData() async{
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
}