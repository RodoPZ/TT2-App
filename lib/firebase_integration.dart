import 'package:cloud_firestore/cloud_firestore.dart';


class Firebase{
  Future getPastilla() async{
    var collection = FirebaseFirestore.instance.collection('Users');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      print(data);
    }
  }
}