import 'package:flutter/material.dart';
import 'package:icar2/Dialogbox/errorDialog.dart';
import 'package:icar2/Dialogbox/loadingDialog.dart';
import 'package:icar2/authenticationScreen.dart';
import 'package:icar2/homescreen.dart';
import 'package:icar2/widgets/customTextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('images/login.png', height: 270.0,),
              ),
            ),
            Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      data: Icons.person,
                      controller: _emailcontroller,
                      hintText: 'Email',
                      isObsocure: false,
                    ),
                    CustomTextField(
                      data: Icons.lock,
                      controller: _passwordcontroller,
                      hintText: 'Password',
                      isObsocure: true,
                    ),
                  ],
                )
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  _emailcontroller.text.isEmpty || _passwordcontroller.text.isEmpty? showDialog(
                      context: context,
                      builder: (con){
                        return ErrorAlertDialog(
                          message: 'please write the required info for login',
                        );
                      }):_login();
                },
          child: Text('Log in', style: TextStyle(color: Colors.white),),
            ),
      ),
              SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
  void _login() async {
    showDialog(context: context,
        builder: (con) {
          return LoadingErrorDialog(
              message: 'please wait');
        });
    User? currentuser;
    await _auth.signInWithEmailAndPassword(
      email: _emailcontroller.text.trim(),
      password: _passwordcontroller.text.trim(),
    ).then((auth){
      currentuser=auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder:(con){
            return ErrorAlertDialog(
                message: error.message.toString());
          }
          );
    });
    if(currentuser!=null){
      Navigator.pop(context);
      Route newRoute=MaterialPageRoute(builder: (context)=>HomeScreen() );
      Navigator.pushReplacement(context, newRoute);
    }
    else{
      print('error');
    }
  }
}