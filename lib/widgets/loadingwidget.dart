import 'package:flutter/material.dart';
circularProgres(){
  return Container(
      alignment:AlignmentDirectional.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.lightGreenAccent
      ),
    ),
  );
}
LinearProgres(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top:12.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
      Colors.lightGreenAccent,
    ),
    ),
  );
}
