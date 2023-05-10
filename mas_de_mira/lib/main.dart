// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mas_de_mira/screens/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mejor de Mira',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const HomeScreen(title: 'Flutter Demo Home Page'),
      home: const SignInScreen(),
    );
  }
}