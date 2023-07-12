import 'package:flutter/material.dart';
import 'package:icar2/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
          appId: '1:987320486478:web:5f68d92fbcaed4ddd6511f',
          apiKey: 'AIzaSyAnnD5cP3h2-QBHmx4RjYgMJxuk5z-3Hw8',
          projectId: 'icar-d4b85',
          messagingSenderId: '987320486478',)
    );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'icar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home:splashScreen()
    );
  }
}

