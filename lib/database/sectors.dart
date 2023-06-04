import 'package:cloud_firestore/cloud_firestore.dart';

class SectorsDB {
  Future getNameSector(String id) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('sectors')
          .where('id', isEqualTo: id)
          .limit(1)
          .get();
      return data.docs.first['name'];
    } catch (e) {
      print(e);
      return '';
    }
  }
}
