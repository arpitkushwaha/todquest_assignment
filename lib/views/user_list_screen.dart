import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/controllers/controller.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
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
                  List<Map<String, dynamic>> listOfUserData =
                  new List<Map<String, dynamic>>();
                  snapshot.data.docs.forEach((document) {
                    listOfUserData.add(document.data());
                  });

                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listOfUserData.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "key: :${listOfUserData[index]["name"]} ${listOfUserData[index]["email"]} ${listOfUserData[index]["timestamp"]}");
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        'Email: ${listOfUserData[index]["email"]}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        'Name: ${listOfUserData[index]["name"]}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${listOfUserData[index]["timestamp"]}"),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),
                              ],
                            ),
                          ),
                          //title: Text(
                          //  "${keys[index].toString()} - ${data[keys[index].toString()].toString()}") //: ${value.values.first.toString()}"),
                          //subtitle: Text(value.toString()),
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
