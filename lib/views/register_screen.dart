import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/utilities/constants.dart';
import 'package:todquest_assignment/utilities/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenToAuthChanges();
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
                  _buildTextField("Enter Name", nameController),
                  _buildTextField("Enter Email", emailController),
                  _buildRegisterBtn(),
                ],
              ),
            )),
      ),
    );
  }


  Widget _buildTextField(
      String title, TextEditingController textEditingController) {
    return TextFormField(
      keyboardType: TextInputType.number,
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
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: title,
        fillColor: Colors.white70,
      ),
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async{
            if (_formKey.currentState.validate()) {
              Constants.userCredentials = await auth.signInAnonymously();
              Navigator.pushNamed(context, Routes.home);
            }
          },
          style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              primary: Colors.black,
              elevation: 5.0),
          child: Text(
            'REGISTER',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('Logged Out');
      } else {
        print('Logged In!');
      }
    });
  }
}
