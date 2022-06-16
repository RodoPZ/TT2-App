import 'package:http/http.dart' as http;

class HTTP{
  Future registerFace(String name) async{
    final response = await http.post(Uri.parse('http://localhost:8080/RegisterFace'),body: name);
    return response.body;
  }
  Future deleteFace(String name) async{
    final response = await http.post(Uri.parse('http://localhost:8080/DeleteFace'),body: name);
    return response.body;
  }
  Future registerNfc() async{
    final response = await http.post(Uri.parse('http://localhost:8080/RegisterNfc'));
    return response.body;
  }
  Future registerAlarm() async{
    final response = await http.post(Uri.parse('http://localhost:8080/RegisterAlarm'));
    return response.body;
  }
  Future registerPill(String contenedor) async{
    final response = await http.post(Uri.parse('http://localhost:8080/MoverMotores'),body: contenedor);
    return response.body;
  }
  Future registerDosis(Map Dosis) async{
    final response = await http.post(Uri.parse('http://localhost:8080/RegisterDosis'), body: Dosis.toString());
    return response.body;
  }
  Future DispensarDosis(String Dosis) async{
    final response = await http.post(Uri.parse('http://localhost:8080/OpenDispensar'), body: Dosis);
    return response.body;
  }
}