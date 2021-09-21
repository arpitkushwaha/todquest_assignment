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
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),


      FutureBuilder(
        future: dirContents(),
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Container();
          }
          else if(projectSnap.hasData)
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${projectSnap.data[index].path}"),
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

  Future<List<FileSystemEntity>> dirContents() async{
    Directory directory;


    try{ directory= await getApplicationSupportDirectory();}
    catch(e)
    {
      print("e == ${e}");
    }
    print("directory.path: ${directory.path}");
    // File file = new File("/dev/dart/work/hello/app.dart");
    // String filename = basename(file.path);
    var files = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = directory.list(recursive: false);
    lister.listen (
            (file) => files.add(file),
        // should also register onError
        onDone:   () {
              completer.complete(files);
              files.forEach((element) {
                print(element.path);
              });
            }
    );
    return completer.future;
  }
}
