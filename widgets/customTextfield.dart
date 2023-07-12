import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsocure=true;
  CustomTextField({ required this.controller,required this.data,required this.hintText,required this.isObsocure,});
  @override
  Widget build(BuildContext context) {
    double _screenwidth=MediaQuery.of(context).size.width;
   double screenheight=MediaQuery.of(context).size.height;

    return Container(
      width: _screenwidth*0.5,
      decoration: BoxDecoration(
        color:Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
        padding: EdgeInsets.all(0.0),
       margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: isObsocure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
            focusColor: Theme.of(context).primaryColor,
        hintText: hintText,
        ),

      ),
    );
  }
}
