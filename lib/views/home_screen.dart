import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController weightTextCon = TextEditingController();
  TextEditingController editWeightTextCon = TextEditingController();
  String weight;
  Controller controller;
  final globalKey = GlobalKey<FormState>();
  final editGlobalKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user_data');
  final Stream<QuerySnapshot> user_data_stream =
  FirebaseFirestore.instance.collection('user_data').snapshots();

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
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Track you weight',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: weightTextCon,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please fill this field';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Weight',
                            fillColor: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (globalKey.currentState.validate()) {
                              controller.addRecordInDb(
                                  users,
                                  WeightModel(
                                      timestamp: DateTime.now().toString(),
                                      weight: weightTextCon.text));
                              weightTextCon.text = "";
                              FocusScope.of(context).unfocus();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(
                                  top: 13, left: 29, right: 29, bottom: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: Colors.blueGrey,
                              elevation: 6.0),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.7,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
                height : 20
            ),

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
                  Map<String, dynamic> data = new Map<String, dynamic>();
                  snapshot.data.docs.forEach((document) {
                    if (document.id == Constants.userCredentials.user.uid) {
                      data = document.data() as Map<String, dynamic>;
                    }
                  });
                  List<DateTime> keys = WeightModel.sortData(data);

                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "key: :${keys[index].toString()} ${data[keys[index].toString()].toString()}");
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('Timestamp: ${keys[index].toString()}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Weight: ${data[keys[index].toString()].toString()}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        editRecordInDb(timestamp: keys[index].toString());
                                      },
                                      child: Text("EDIT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),),),

                                    TextButton(
                                      onPressed: () {
                                        controller.deleteRecordFromDb(users, WeightModel(timestamp: keys[index].toString()));
                                      },
                                      child: Text("DELETE",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),),)
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


  Future<void> editRecordInDb({String timestamp}) {

    showDialog(context: context, builder:(BuildContext buildContext){
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            child: Form(
              key: editGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: editWeightTextCon,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Enter new weight',
                        fillColor: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (editGlobalKey.currentState.validate()) {
                          controller.addRecordInDb(
                              users,
                              WeightModel(
                                  timestamp:timestamp,
                                  weight: editWeightTextCon.text));
                          editWeightTextCon.text = "";
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 13, left: 29, right: 29, bottom: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          primary: Colors.blueGrey,
                          elevation: 6.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.7,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

    });
  }
}
