// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/login.dart';

class UsersDB {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future getDataUser(String uid) async {
    try {
      DocumentSnapshot res = await users.doc(uid).get();
      return res.data();
    } catch (e) {
      if (kDebugMode) {
        print("Failed to add user: $e");
      }
    }
  }

  Future updateUser(Map<String, Object> data, String idUser) async {
    try {
      await users.doc(idUser).update(data);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to update user: $e");
      }
      return false;
    }
  }
}
