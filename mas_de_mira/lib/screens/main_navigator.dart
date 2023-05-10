import 'package:flutter/material.dart';
import 'package:mas_de_mira/constants.dart';
import 'package:mas_de_mira/screens/camera.dart';
import 'package:mas_de_mira/screens/cart.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key, required this.title});

  final String title;

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {

  String appBarTitle = "Mi Lista";

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
      CartScreen(),
      CameraScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        appBarTitle = "Mi Lista";
      }
      else{
        appBarTitle = "Cuenta";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.amazonnavy,
        centerTitle: true,
        title: 
        Text(
          appBarTitle,
          style: const TextStyle(
            fontFamily: "Amazon",
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
          ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstants.amazonnavy,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Captura',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppConstants.amazonorange,
        unselectedItemColor: AppConstants.white,
        onTap: _onItemTapped,
      ),
    );
  }
}