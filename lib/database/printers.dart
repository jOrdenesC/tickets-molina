import 'package:cloud_firestore/cloud_firestore.dart';

class PrintersDB {
  Future getNamePrinters(String id) async {
    try {
      var data =
          await FirebaseFirestore.instance.collection('printers').doc(id).get();
      return data['name'];
    } catch (e) {
      print(e);
      return '';
    }
  }
}
