import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:stop_shop/screens/authentication/signin.dart';
import 'package:stop_shop/screens/likedItems.dart';

import 'package:stop_shop/screens/services/auth.dart';
import 'package:stop_shop/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/user.dart';
import 'package:splash_screen_view/splash_screen_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BeforeMyApp());
}

class BeforeMyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserUid?>.value(
            initialData: null,
            value: AuthService().user,
            // ignore: non_constant_identifier_names
            catchError: (User, UserUid) => null,
            child: MaterialApp(
              title: 'E-commerce app',
              theme: ThemeData(
                primaryColor: Colors.grey[200],
                scaffoldBackgroundColor: Colors.grey[190],
              ),
              home: MyApp(),
              routes: {
                'splashMyApp': (context) => BeforeMyApp(),
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splashScreen = SplashScreenView(
      navigateRoute: Wrapper(),
      duration: 5000,
      imageSize: 200,
      imageSrc: 'assets/one-stop-shop-logos.png',
      text: "whatever you want...",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
          fontSize: 40.0, fontWeight: FontWeight.bold, fontFamily: 'cursive'),
      colors: [
        Colors.black,
        Colors.black54,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.black38,
        Colors.black54,
        Colors.black,
      ],
      backgroundColor: Colors.white,
    );
    return Scaffold(
      body: splashScreen,
    );
  }
}
