import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentsDB {
  Future getNameDepartment(String id) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('departamentos')
          .doc(id)
          .get();
      return data['name'];
    } catch (e) {
      print(e);
      return '';
    }
  }
}
