import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets/database/users.dart';

class PendingAllTickets extends StatefulWidget {
  const PendingAllTickets({super.key});

  @override
  State<PendingAllTickets> createState() => _PendingAllTicketsState();
}

class _PendingAllTicketsState extends State<PendingAllTickets> {
  String myId = '';
  final format = DateFormat('dd MMMM, yyyy hh:mm', 'es_ES');
  @override
  void initState() {
    super.initState();
    getMyId();
    updateToken();
  }

  getMyId() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      myId = prefs.getString('uid')!;
    });
  }

  updateToken() async {
    var prefs = await SharedPreferences.getInstance();
    var token = await FirebaseMessaging.instance.getToken();

    if (prefs.getString('uid')! != token) {
      print('uid actualizado $token');
      UsersDB().updateUser({'token': token!}, prefs.getString('uid')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Pending All Tickets'),
      ),
    );
  }
}
