import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/controllers/controller.dart';
import 'package:todquest_assignment/utilities/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
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
      backgroundColor: Colors.blueGrey,
      title: Text(
        'Todquest',
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            controller.logOut();
          },
        )
      ],
    ),
      body: Column(
        children: [
          _buildUIBtn(),
          _buildPathBtn(),
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
              Navigator.pushNamed(context, Routes.ui);
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
            'Display UI of Button',
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
            Navigator.pushNamed(context, Routes.path);
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
            'Print Path Of Directory',
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
            Navigator.pushNamed(context, Routes.userList);
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
            'Print User List',
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
