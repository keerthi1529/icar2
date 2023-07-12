import 'package:flutter/material.dart';
import 'package:icar2/authenticationScreen.dart';

class ErrorAlertDialog extends StatelessWidget {
   final String message;
   const ErrorAlertDialog({required this.message});
   
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
            onPressed: (){
          Route newRoute=MaterialPageRoute(
              builder: (context)=>AuthenticationScreen()
          );
            },
            child: Text('Ok')
        )
      ],
    );
  }
}
