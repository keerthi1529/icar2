import 'package:flutter/material.dart';
import 'package:icar2/Dialogbox/errorDialog.dart';
import 'package:icar2/homescreen.dart';
import 'package:icar2/widgets/customTextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icar2/globalvar.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<FormState> _formkey= GlobalKey<FormState>();
final TextEditingController _emailcontroller=TextEditingController();
final TextEditingController _passwordcontroller=TextEditingController();
final TextEditingController _namecontroller=TextEditingController();
final TextEditingController _phonenumbercontroller=TextEditingController();
final TextEditingController _imagecontroller=TextEditingController();
final TextEditingController _passwordConfirmcontroller=TextEditingController();
final FirebaseAuth _auth =FirebaseAuth.instance;

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 10.0,),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('images/register.png',height: 270,),
            ),
          ),
          SizedBox(height: 8.0,),
          Form(
              key: _formkey,
              child:Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person,
                    controller: _namecontroller,
                    hintText: 'Name',
                    isObsocure:false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: _emailcontroller,
                    hintText: 'Email',
                    isObsocure:false,
                  ),
                  CustomTextField(
                    data: Icons.person,
                    controller: _phonenumbercontroller,
                    hintText: 'Phone',
                    isObsocure:false,
                  ),
                  CustomTextField(
                    data: Icons.camera_alt_outlined,
                    controller: _imagecontroller,
                    hintText: 'Image URL',
                    isObsocure:false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _passwordcontroller,
                    hintText: 'Password',
                    isObsocure:true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _passwordConfirmcontroller,
                    hintText: 'Confirm Password',
                    isObsocure:true,
                  )
                ],
              )),
          SizedBox(height: 10.0,),
          Container(
            width: MediaQuery.of(context).size.height*0.5,
            child: ElevatedButton(
              onPressed: (){
                _register();
              },
              child:Text('Sign Up',style: TextStyle(color: Colors.white,),),

            ),
          )
        ],
      ),
    )
    );
  }

  void saveUserData(){
    Map<String,dynamic> userData={
      'userName':_namecontroller.text.trim(),
      'uid':userid,
      'userNumber':_phonenumbercontroller.text.trim(),
      'ImgPro':_imagecontroller.text.trim(),
      'time':DateTime.now(),
    };
    FirebaseFirestore.instance.collection('users').doc(userid).set(userData);
  }

  void _register() async{
    await Firebase.initializeApp();

    User? currentUser;
      await _auth.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim()
      ).then((auth) {
        currentUser = auth.user;
        userid = currentUser!.uid;
        userEmail = currentUser!.email;
        getUserName = _namecontroller.text.trim();
        saveUserData();
      }).catchError((error) {
        Navigator.pop(context);
        showDialog(context: context,
            builder: (con) {
              return ErrorAlertDialog(
                  message: error.message.toString()
              );
            });
      });
      if (currentUser != null) {
        Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      }
  }
}
