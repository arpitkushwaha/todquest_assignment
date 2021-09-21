import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/controllers/controller.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController weightTextCon = TextEditingController();
  TextEditingController editWeightTextCon = TextEditingController();
  String weight;
  Controller controller;
  final globalKey = GlobalKey<FormState>();
  final editGlobalKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> user_data_stream =
  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Controller(buildContext: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'User Details Assignment',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: user_data_stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if (snapshot.hasData) {
                  List<Map<String, dynamic>> userList = [];
                  snapshot.data.docs.forEach((document) {
                    userList.add(document.data());
                  });

                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: userList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "key: :${userList[index]["name"]} ${userList[index]["email"]} ${userList[index]["timestamp"]}");
                        return Padding(
                          padding: EdgeInsets.only(left: 18, right: 18),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("USER DETAILS", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),),
                                  Text(
                                      '${userList[index]["email"]}'),
                                  Text(
                                      '${userList[index]["name"]}'),
                                ],
                              ),
                            ),
                            //title: Text(
                            //  "${keys[index].toString()} - ${data[keys[index].toString()].toString()}") //: ${value.values.first.toString()}"),
                            //subtitle: Text(value.toString()),
                          ),
                        );
                      });
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
