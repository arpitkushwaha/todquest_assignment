import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiScreen extends StatefulWidget {
  const UiScreen({Key key}) : super(key: key);

  @override
  _UiScreenState createState() => _UiScreenState();
}

class _UiScreenState extends State<UiScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Iam UI");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Center(
          child: Card(
            shape: Border(right: BorderSide(color: Colors.red, width: 5)),
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
    );
  }
}
