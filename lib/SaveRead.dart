import 'dart:convert';
import 'package:tt2/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models.dart';
import 'package:tt2/Components/httpComunications.dart';

class SaveRead{
  final _http = HTTP();

  Future saveUserData(UserData userData) async{
    var collection = FirebaseFirestore.instance.collection('/Users/');
    var querySnapshot = await collection.get();
    await collection.add({
    "nombre": userData.nombreUsuario,
    "apellido": userData.apellidoUsuario,
    "correo": userData.correo,
    "contraseña": userData.password,
    "Pin": userData.pin,
    }).then((value) => print("User Added"));
  }

  Future savePastilla(Pastilla pastilla) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    var querySnapshot = await collection.get();
    int pastillasData = querySnapshot.docs.length;
      if (pastillasData < 10){
        await collection.add({
            "contenedor":pastilla.contenedor,
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
      await collection.add({
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
      await collection.add({
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
      await collection.add({
        "nombre": dosis.dosisNombre,
        "pastillas": dosis.pastillaData,
        "horario": dosis.horarioData,
        "alarmas": dosis.alarmaData,
        "seguridad": dosis.seguridadData,
      }).then((value) => callback(value.id.hashCode));

    }
  }

  Future saveNfc(Nfc nfc) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    int nfcData = querySnapshot.docs.length;
    if (nfcData <= 20){
      await collection.add({
        "tipo": nfc.tipo,
        "nombre": nfc.nfcNombre,
        "uid": nfc.uid,
        "admin": nfc.isAdmin,
      });
    }
  }

  Future saveFace(FaceRecognition faceRecognition) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    int faceData = querySnapshot.docs.length;
    if (faceData <= 20){
      await collection.add({
        "tipo": faceRecognition.tipo,
        "nombre": faceRecognition.faceRName,
        "admin": faceRecognition.isAdmin,
      });
    }
  }

  Future savePin(Pin pin) async {
    late bool exists = false;
    var collection = FirebaseFirestore.instance.collection(
        '/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      print(queryDocumentSnapshot.data());
      if (queryDocumentSnapshot.data()["tipo"] == "PIN") {
        await collection.doc(queryDocumentSnapshot.reference.id).update({
          "pinData": pin.pin,
          "admin": pin.admin,
          "tipo": pin.tipo,
        }).then((value) => print("User Added"));
        exists = true;
        break;
      }
    }
    if(exists == false){
      await collection.add({
        "pinData": pin.pin,
        "tipo": pin.tipo,
        "admin": pin.admin,
      });
    }
  }


  Future deleteContacto(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Contactos/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deletePastilla(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Pastillas/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteHorario(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Horarios/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteDosis(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Dosis/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteNfc(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }


  Future deletePin(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    await collection.doc(id).delete().then((value) => print("Deleted"));
  }

  Future deleteFace(String id) async{
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad/');
    var querySnapshot = await collection.doc(id).get();
    await _http.deleteFace(querySnapshot.data()!["nombre"]);
    await collection.doc(id).delete().then((value) => print("Deleted"));
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
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if(queryDocumentSnapshot.data()["tipo"] == "PIN") {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data["serverid"]=queryDocumentSnapshot.id;
        return data;
      }
    }

  }

  Future getNfc() async {
    List nfcData = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if(queryDocumentSnapshot.data()["tipo"] == "NFC"){
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
      if(queryDocumentSnapshot.data()["tipo"] == "RECONOCIMIENTO FACIAL") {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        data["serverid"]=queryDocumentSnapshot.id;
        faceData.add(data);
      }
    }
    return faceData;
  }

  Future getSeguridad() async {
    List seguridad = [];
    var collection = FirebaseFirestore.instance.collection('/Users/2aZ3V4Ik89e9rDSzo4N9/Seguridad');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      data["serverid"]=queryDocumentSnapshot.id;
      seguridad.add(data);
    }
    return seguridad;
  }

  Future pillSubstraction(String pastillas) async{
    List pills = jsonDecode(pastillas);
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