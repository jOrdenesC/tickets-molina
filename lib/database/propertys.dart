import 'package:cloud_firestore/cloud_firestore.dart';

class PropertysDB {
  Future getNamePropertys(String id) async {
    try {
      var data =
          await FirebaseFirestore.instance.collection('property').doc(id).get();
      return data['name'];
    } catch (e) {
      print(e);
      return '';
    }
  }
}
