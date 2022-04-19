
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt2/models.dart';
import 'dart:math';

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
    final List <int>_id = [];
    int _newid = 0;
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('pastillasData')){
      List pastillasData = jsonDecode(preferences.getString('pastillasData')!);

      if (pastillasData.isNotEmpty){
        for (var value in pastillasData) {
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
      if (pastillasData.length < 10){
        pastillasData.add({
          "id":_newid,
          "nombre":pastilla.pastillaNombre,
          "cantidad":pastilla.pastillaCantidad,
          "caducidad":pastilla.pastillaCaducidad,
        });
        await preferences.setString("pastillasData", jsonEncode(pastillasData));
      }
    }
    else{
      List pastillasData = [{'id':0,'nombre':pastilla.pastillaNombre, "cantidad":pastilla.pastillaCantidad,"caducidad":pastilla.pastillaCaducidad,}];
      await preferences.setString("pastillasData",jsonEncode(pastillasData));
    }
  }

  Future saveHorario(Horario horario) async{
    final List <int>_id = [];
    int _newid = 0;

    final preferences = await SharedPreferences.getInstance();
    //preferences.remove("horariosData");
    //Asignar una id única
    if (preferences.containsKey('horariosData')){
      List horariosData = jsonDecode(preferences.getString('horariosData')!);

      if (horariosData.isNotEmpty){
        for (var value in horariosData) {
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
      if (horariosData.length < 10){
        horariosData.add({
          "id":_newid,
          "hora":horario.horarioHora,
          "repetir":horario.horarioRepetir
        });
        await preferences.setString("horariosData", jsonEncode(horariosData));
      }
    }
    else{
      List horariosData = [{'id':0,'hora':horario.horarioHora, 'repetir':horario.horarioRepetir}];
      await preferences.setString("horariosData",jsonEncode(horariosData));
    }
  }

  Future saveContacto(Contacto contacto) async{
    final List <int>_id = [];
    int _newid = 0;
    //Asignar una id única

    final preferences = await SharedPreferences.getInstance();
    //preferences.remove("contactosData");
    if (preferences.containsKey('contactosData')){
      List contactosData = jsonDecode(preferences.getString('contactosData')!);
      if (contactosData.isNotEmpty){
        for (var value in contactosData) {
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
      if (contactosData.length < 20){
        contactosData.add({
          "id": _newid,
          "nombre": contacto.contactoNombre,
          "numero": contacto.contactoNumero
        });
        await preferences.setString("contactosData", jsonEncode(contactosData));
      }
    }
    else{
      List contactosData = [{'id':0,'nombre':contacto.contactoNombre,'numero':contacto.contactoNumero}];
      await preferences.setString("contactosData",jsonEncode(contactosData));
    }
  }

  Future saveDosis(Dosis dosis) async{
    final List <int>_id = [];
    int _newid = 0;
    //Asignar una id única

    final preferences = await SharedPreferences.getInstance();
    //preferences.remove("dosisData");
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
        await preferences.setString("dosisData", jsonEncode(dosisData));
      }
    }
    else{
      List dosisData = [{'id':0,'nombre':dosis.dosisNombre,'pastillas':dosis.pastillaData,'horario':dosis.horarioData,"alarmas": dosis.alarmaData,"seguridad": dosis.seguridadData}];
      await preferences.setString("dosisData",jsonEncode(dosisData));
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
    List horariosData = jsonDecode(preferences.getString('horariosData')!);
    horariosData.removeAt(index);
    await preferences.setString("horariosData", jsonEncode(horariosData));
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