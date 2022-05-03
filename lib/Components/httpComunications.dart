import 'package:http/http.dart' as http;

class HTTP{
  Future fetchAlbum() async{
    final response = await http.get(Uri.parse('http://192.168.0.11:8080'));
    print(response.body);
  }
}