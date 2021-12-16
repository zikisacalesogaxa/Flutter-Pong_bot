import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pong_bot/screens/dashboard.dart';
import 'package:pong_bot/screens/authentication/login.dart';
import 'package:pong_bot/screens/authentication/register.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
bool isLoggedIn = false;

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: _routes(),
      home: isLoggedIn ? DashboardPage() : LoginPage(),
    );
  }
}

_routes() {
  return {
    '/dashboard': (BuildContext context) => DashboardPage(),
    '/login': (BuildContext context) => LoginPage(),
    '/register': (BuildContext context) => RegisterPage(),
  };
}
