import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/controllers/controller.dart';
import 'package:todquest_assignment/helper/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  Controller controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Controller();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        'Todquest Assignment APP',
      ),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUIBtn(),
          SizedBox(height: 20,),
          _buildPathBtn(),
          SizedBox(height: 20,),
          _buildUserListBtn(),
        ],
      ),

    );
  }

  Widget _buildUIBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
              Navigator.pushNamed(context, Screens.card);
          },
          style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
              primary: Colors.blue,
              elevation: 5.0),
          child: Text(
            'Card ASSIGNMENT',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget _buildPathBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, Screens.path);
          },
          style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
              primary: Colors.blue,
              elevation: 5.0),
          child: Text(
            'Path ASSIGNMENT',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget _buildUserListBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            Navigator.pushNamed(context, Screens.users);
          },
          style: ElevatedButton.styleFrom(
              padding:
              EdgeInsets.only(top: 12, left: 30, right: 30, bottom: 12),
              primary: Colors.blue,
              elevation: 5.0),
          child: Text(
            'User Details ASSIGNMENT',
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
