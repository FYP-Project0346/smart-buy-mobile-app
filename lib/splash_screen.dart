import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartbuy/screens/home/home.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Home()), (route) => false));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Ensure this path matches the actual asset path
              width: 150, // Set the width as needed
              height: 150, // Set the height as needed
            ),
            Text("Smart Buy",style: TextStyle(fontWeight: FontWeight.bold,),)
          ],
        ),
      ),
    );
  }
}
