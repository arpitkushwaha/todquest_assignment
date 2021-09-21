import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/controllers/controller.dart';
import 'package:todquest_assignment/models/user.dart';
import 'package:todquest_assignment/helper/commons.dart';
import 'package:todquest_assignment/helper/screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Controller controller;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Controller(buildContext: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextField("Enter your full name", nameController),
                  SizedBox(height: 30,),
                  _buildTextField("Enter your email", emailController),
                  SizedBox(height: 60,),
                  _buildLoginBtn(),
                ],
              ),
            )),
      ),
    );
  }


  Widget _buildTextField(
      String title, TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      validator: (value) {
        if (value.isEmpty) {
          return 'This field cannot be left empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.black),
        hintText: title,
        fillColor: Colors.white70,
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              Commons.userCredential = await auth.signInAnonymously();
              controller.createUser(
                  users,
                  UserM(
                      timestamp: DateTime.now().toString(),
                      name: nameController.text,
                  email: emailController.text));

              Navigator.pushNamed(context, Screens.main);
            }
          },
          style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
              primary: Colors.blue,
              elevation: 5.0),
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

}
