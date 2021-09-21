import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Card Assignment',
          ),
        ),
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
        height: MediaQuery.of(context).size.height-500,
        width: MediaQuery.of(context).size.width-150,
        child: Material(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(150),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color:Colors.deepOrangeAccent[100],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(150),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.deepOrangeAccent[100],
                style: BorderStyle.solid,
              ),
            ),
            child: getStack(),
          ),
        ),
          ),
      )),
    ));
  }

  Widget getStack()
  {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/images/image.png', width: 80,height: 80,)),
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
                height: 20,
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
      ],
    );
  }
}
