import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/utilities/routes.dart';
import 'package:todquest_assignment/views/home_screen.dart';
import 'package:todquest_assignment/views/path_screen.dart';
import 'package:todquest_assignment/views/register_screen.dart';
import 'package:todquest_assignment/views/ui_screen.dart';
import 'package:todquest_assignment/views/user_list_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todquest App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.register,
      routes: {
        Routes.register: (context) => RegisterScreen(),
        Routes.home: (context) => HomeScreen(),
        Routes.userList: (context) => UserListScreen(),
        Routes.path: (context) => PathScreen(),
        Routes.ui: (context) => UiScreen(),
      },
    );
  }
}
