import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todquest_assignment/models/user.dart';

class Controller {
  BuildContext buildContext;
  Controller({this.buildContext});


  Future<void> createUser(
      CollectionReference users, UserM user) {
    users
        .add({"name": user.name, "email": user.email, "timestamp": user.timestamp});
  }
}