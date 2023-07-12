import 'package:flutter/material.dart';
import 'package:icar2/authenticationScreen.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icar2/homescreen.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  startTimer(){
    Timer(Duration(seconds: 5),(){
      if(FirebaseAuth.instance.currentUser!=null){
       Route newRoute=MaterialPageRoute(builder: (context)=>HomeScreen());
        Navigator.push(context, newRoute);
      }
      else{
        Route newRoute=MaterialPageRoute(builder: (context)=>AuthenticationScreen());
        Navigator.push(context, newRoute);
      }
    });
  }

  @override
  void initState(){
    super.initState();
    startTimer();
  }
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration:  new BoxDecoration(
          gradient: new LinearGradient(
              colors:[
                    Colors.blueAccent,
                    Colors.redAccent,
              ],
            begin: const FractionalOffset(0.0,0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              SizedBox(height: 20.0,),
              Text('from Coding cafe',
              style: TextStyle(fontSize: 60.0,
              color: Colors.white,
              fontFamily: 'Lobster'),
              )
            ],
          ),
        ),
      )
    );
  }
}
