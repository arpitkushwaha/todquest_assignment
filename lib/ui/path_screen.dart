import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({Key key}) : super(key: key);

  @override
  _PathScreenState createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Path Assignment',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: getAllFiles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                return Container();
              } else if (snapshot.hasData)
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("PATH: ", style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("${snapshot.data[index].path}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              else
                return Container();
            },
          )
        ],
      ),
    );
  }

  Future<List<FileSystemEntity>> getAllFiles() async {
    Directory directory;
    try {
      directory = await getApplicationSupportDirectory();
    } catch (e) {
      print("Exception $e");
    }
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = directory.list(recursive: false);
    lister.listen((file) => files.add(file),
        onDone: () => completer.complete(files));
    return completer.future;
  }
}
