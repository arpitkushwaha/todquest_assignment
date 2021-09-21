import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:todquest_assignment/models/user_model.dart';
import 'package:todquest_assignment/utilities/constants.dart';

class Controller {
  BuildContext buildContext;
  Controller({this.buildContext});

  void logOut() async {
    FirebaseAuth.instance.signOut();
    SystemNavigator.pop();
  }

  Future<void> deleteRecordFromDb(
      CollectionReference users, UserModel user) {
    return users
        .doc(Constants.userCredentials.user.uid)
        .set({user.name: FieldValue.delete(), user.email: FieldValue.delete(), user.timestamp: FieldValue.delete()}, SetOptions(merge: true));
  }

  Future<void> addRecordInDb(
      CollectionReference users, UserModel user) {
    users
        .add({"name": user.name, "email": user.email, "timestamp": user.timestamp});
  }
}