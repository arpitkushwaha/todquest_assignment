import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todquest_assignment/helper/screens.dart';
import 'package:todquest_assignment/ui/card_screen.dart';
import 'package:todquest_assignment/ui/login_screen.dart';
import 'package:todquest_assignment/ui/main_screen.dart';
import 'package:todquest_assignment/ui/path_screen.dart';
import 'package:todquest_assignment/ui/users_screen.dart';


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
      title: 'Todquest Assignment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Screens.login,
      routes: {
        Screens.login: (context) => LoginScreen(),
        Screens.main: (context) => MainScreen(),
        Screens.users: (context) => UsersScreen(),
        Screens.path: (context) => PathScreen(),
        Screens.card: (context) => CardScreen(),
      },
    );
  }
}
