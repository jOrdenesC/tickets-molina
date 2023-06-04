import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsDB {
  static Stream getMyTickets(String myId) => FirebaseFirestore.instance
      .collection('tickets')
      .where('idUser', isEqualTo: myId)
      .where('status', isEqualTo: 'pending')
      .snapshots();

  Future updateTicket(String details, String id) async {
    try {
      FirebaseFirestore.instance.collection('tickets').doc(id).update({
        'resolution': details,
        'status': 'resolved',
        'dateResolved': FieldValue.serverTimestamp()
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
