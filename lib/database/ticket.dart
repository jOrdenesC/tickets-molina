import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
        'status': 'revision',
        'dateResolved': FieldValue.serverTimestamp()
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future pendingTicket(String details, String id) async {
    try {
      FirebaseFirestore.instance.collection('tickets').doc(id).update({
        'pending': details,
        'status': 'pending-proovedor',
        'datePending': FieldValue.serverTimestamp()
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  static Stream getMyTicketsRed(String myId) => FirebaseFirestore.instance
      .collection('tickets-red')
      .where('assign', isEqualTo: myId)
      .where('status', isEqualTo: 'pending')
      .snapshots();

  Future updateTicketRed(String details, String id) async {
    try {
      FirebaseFirestore.instance.collection('tickets-red').doc(id).update({
        'resolution': details,
        'status': 'revision',
        'dateResolved': FieldValue.serverTimestamp()
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future pendingTicketsRed(String details, String id) async {
    try {
      FirebaseFirestore.instance.collection('tickets-red').doc(id).update({
        'pending': details,
        'status': 'pending-proovedor',
        'datePending': FieldValue.serverTimestamp()
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future getPendingPrinters(String myId) => FirebaseFirestore.instance
      .collection('tickets')
      .where('idUser', isEqualTo: myId)
      .where('status', isEqualTo: 'pending-proovedor')
      .get();

  Future getPendingRed(String myId) => FirebaseFirestore.instance
      .collection('tickets-red')
      .where('assign', isEqualTo: myId)
      .where('status', isEqualTo: 'pending-proovedor')
      .get();
}
