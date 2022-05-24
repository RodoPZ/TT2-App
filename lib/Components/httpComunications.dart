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
}