import 'package:flutter/material.dart';
// import 'package:jklu_eezy/pages/announcements.dart';
import 'package:jklu_eezy/pages/signup.dart';
// import 'package:jklu_eezy/pages/home.dart';
// import 'package:jklu_eezy/pages/splashscreen.dart';
// import '../../apicall/userdetails.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{ 
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JKLU Eezy',
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(),
      home: const SignUpPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Home(),
      // body: SignUpPage(),
      // body: Announcements(),
      // body: SplashScreen(),
      // body: getUserDetails(),
      // body: ContactDirectoryAdmin(),
    );
  }
}
