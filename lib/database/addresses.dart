import 'package:cloud_firestore/cloud_firestore.dart';

class AddressesDB {
  Future getNameAddresses(String id) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('addresses')
          .doc(id)
          .get();
      return data['name'];
    } catch (e) {
      print(e);
      return '';
    }
  }
}
