import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/constants/constants.dart';
import 'package:qr_scanner_generator/screens/HomeScreen/bottom_nav.dart';
import 'package:qr_scanner_generator/screens/HomeScreen/home_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(BottomNav.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Expanded(
            child: Container(
          width: double.infinity,
          color: kSecondaryColor,
          child: Icon(
            Icons.qr_code_sharp,
            size: 250,
            color: kPrimaryColor,
          ),
        )),
      ],
    ));
  }
}
