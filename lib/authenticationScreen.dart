import 'package:flutter/material.dart';
import 'package:icar2/login.dart';
import 'package:icar2/registration.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace:Container(
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
          ),
     title:Text(
            'icar',
          style:TextStyle(
              fontSize:60.0,
              color:Colors.white,
              fontFamily:'Lebster'),
        ),
          centerTitle: true,
           bottom: TabBar(
    tabs:[
        Tab(
    icon: Icon(Icons.lock,color: Colors.white,),
    text: "Login",
    ),
    Tab(
    icon: Icon(Icons.person,color: Colors.white,),
    text: "Register",
    )
    ],
    indicatorColor: Colors.white38,
    indicatorWeight: 5.0,
    ),
        ),
    body:Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors:[
    Colors.blueAccent,
    Colors.redAccent,
    ],
    )
    ),
      child: TabBarView(
        children: <Widget>[
          LoginPage(),
        RegistrationPage()
        ],
      ),
    ),
    ),
    );
  }
}
