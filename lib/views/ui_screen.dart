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
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children : [
            SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Material(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(90),
              ),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color:Colors.deepOrangeAccent[100],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(90),
                  ),
                  border: Border.all(
                    color: Colors.deepOrangeAccent[100],
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
            Align(
              alignment: Alignment.topLeft,
                child: Image.asset('assets/images/bread.png', width: 200,height: 200,)),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Breakfast",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Bread,",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "PeanutButter,",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Apple,",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "525",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "kcal",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
        ]
        ),
      )),
    ));
  }
}
