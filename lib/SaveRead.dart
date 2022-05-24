import 'dart:convert';
import 'package:tt2/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import 'package:tt2/Components/httpComunications.dart';

class SaveRead{
  final _http = HTTP();
  // Future saveUser(UserData userData) async{
  //   final preferences = await SharedPreferences.getInstance();
  //   await preferences.setString("nombreUsuario", userData.nombreUsuario);
  //   await preferences.setString("apellidoUsuario", userData.apellidoUsuario);
  //   await preferences.setString("correo", userData.correo);
  //   await preferences.setString("contraseña", userData.password);
  //   await preferences.setBool("esPaciente", userData.esPaciente);
  // }

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
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/');
    var querySnapshot = await collection.get();
    int dosisData = querySnapshot.docs.length;
    if (dosisData < 100){
      collection.add({
        "nombre": dosis.dosisNombre,
        "pastillas": dosis.pastillaData,
        "horario": dosis.horarioData,
        "alarmas": dosis.alarmaData,
        "seguridad": dosis.seguridadData,
      }).then((value) => callback(value.id.hashCode));

    }
  }

  Future savePin(Pin pin) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    int pinData = querySnapshot.docs.length;
    if (pinData <= 1) {
      collection.doc(querySnapshot.docs[0].reference.id).update({
        "pinData": pin.pin,
        "tipo": pin.tipo,
      }).then((value) => print("User Added"));
    }
  }

  Future saveNfc(Nfc nfc) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    int nfcData = querySnapshot.docs.length;
    if (nfcData <= 20){
      collection.add({
        "tipo": nfc.tipo,
        "nombre": nfc.nfcNombre,
        "id": nfc.uid,
        "admin": nfc.isAdmin,
      });
    }
  }

  Future saveFace(FaceRecognition faceRecognition) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    int faceData = querySnapshot.docs.length;
    if (faceData <= 20){
      collection.add({
        "tipo": faceRecognition.tipo,
        "nombre": faceRecognition.faceRName,
        "admin": faceRecognition.isAdmin,
      });
    }
  }


  Future deleteContacto(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Contactos/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deletePastilla(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteHorario(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteDosis(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteNfc(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }


  Future deletePin(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteFace(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.doc(id).get();
    await _http.deleteFace(querySnapshot.data()!["nombre"]);
    collection.doc(id).delete().then((value) => print("Deleted"));
  }

  // Future getUserData() async{
  //   final preferences = await SharedPreferences.getInstance();
  //   final String? nombreUsuario = preferences.getString("nombreUsuario");
  //   final String? apellidoUsuario = preferences.getString("apellidoUsuario");
  //   final String? correo =  preferences.getString("correo");
  //   final String? password =  preferences.getString("contraseña");
  //   final bool? esPaciente =  preferences.getBool("esPaciente");
  //
  //   return UserData(nombreUsuario: nombreUsuario!, apellidoUsuario: apellidoUsuario!, correo: correo!, password: password!, esPaciente: esPaciente!);
  // }

  Future getPastilla() async{
    List pastillasData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      data["serverid"]=queryDocumentSnapshot.id;
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
      data["serverid"]=queryDocumentSnapshot.id;
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
      data["serverid"]=queryDocumentSnapshot.id;
      contactosData.add(data);
    }
    return contactosData;
  }

  Future getDosis() async{
    List dosisData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      data["serverid"]=queryDocumentSnapshot.id;
      dosisData.add(data);
    }
    return dosisData;
  }

  Future getPin() async {
    late String pinData = "";
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if(queryDocumentSnapshot.data()["tipo"] == "pin") {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data["serverid"]=queryDocumentSnapshot.id;
        pinData = data.toString();
      }
    }
    return pinData;
  }

  Future getNfc() async {
    List nfcData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if(queryDocumentSnapshot.data()["tipo"] == "nfc"){
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data["serverid"]=queryDocumentSnapshot.id;
        nfcData.add(data);
      }
    }
    return nfcData;
  }

  Future getFace() async {
    List faceData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if(queryDocumentSnapshot.data()["tipo"] == "face") {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data["serverid"]=queryDocumentSnapshot.id;
        faceData.add(data);
      }
    }
    return faceData;
  }

  Future pillSubstraction(String pastillas) async{
    List pills = jsonDecode(pastillas);
    List pastillasData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    for (var pill in pills){
      for (var queryDocumentSnapshot in querySnapshot.docs) {
        if(pill[0] == queryDocumentSnapshot.reference.id){
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          if(data['cantidad']> 0){
            collection.doc(queryDocumentSnapshot.reference.id).update({'cantidad':data['cantidad']-pill[1]});
          }
        }
      }
    }
  }
}