import 'package:flutter/material.dart';
import 'package:icar2/widgets/loadingwidget.dart';

class LoadingErrorDialog extends StatelessWidget {

  final String message;
  const LoadingErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          circularProgres(),
          SizedBox(
            height: 10,
          ),
          Text('Authenticating, Please wait..'),
        ],
      ),
    );
  }
}
