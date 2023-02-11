import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_generator/constants/constants.dart';
import 'package:qr_scanner_generator/routes.dart';
import 'package:qr_scanner_generator/screens/splash/splash.dart';

void main() {
  runApp(AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(statusBarColor: kPrimaryColor.withOpacity(0.7)),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      // We use routeName so that we dont need to remember the name
      initialRoute: Splash.routeName,
      routes: routes,
    );
  }
}
