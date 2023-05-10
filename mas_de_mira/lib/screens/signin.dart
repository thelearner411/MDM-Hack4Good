import 'package:flutter/material.dart';
import 'package:mas_de_mira/constants.dart';
import 'package:mas_de_mira/screens/main_navigator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.amazonnavy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mejor de Mira',
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Amazon",
                fontWeight: FontWeight.w900,
                color: AppConstants.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
                Image.asset(
                  "assets/mejor-de-mira-logo.png", height: 250, width: 250,
                ),
            const SizedBox(height: 50),
            AmazonSignInButton(),
          ],
        ),
      ),
    );
  }
}

class AmazonSignInButton extends StatelessWidget {
  const AmazonSignInButton({super.key});

  @override
  Widget build(BuildContext context){
      return  ElevatedButton.icon(
          style: amazonSignInButtonStyle,
          icon: Image.asset("assets/amazon-logo-square.png", height: 20, width: 20),
          label: const Text(
            'Entra',
            style: TextStyle(
              fontSize: 20, 
              fontFamily: "OpenSans", 
              fontWeight: FontWeight.w800,
              color: AppConstants.amazonblack,
            ),
          ),
          onPressed: () async {
   
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MainNavigatorScreen(title: '',),
          ),
        );
  
    }
  );
  }
}

final ButtonStyle amazonSignInButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppConstants.lightgrey,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.all(15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  textStyle: const TextStyle(
    fontSize: 20, 
    fontFamily: "OpenSans", 
    color: AppConstants.amazonorange),
);