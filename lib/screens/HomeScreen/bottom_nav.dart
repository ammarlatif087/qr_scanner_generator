import 'package:flutter/material.dart';
import 'package:qr_scanner_generator/screens/QrGenerator/qr_generator_screen.dart';
import 'package:qr_scanner_generator/screens/QrScanScreen/qr_scan_screen.dart';

import '../../constants/constants.dart';

class BottomNav extends StatefulWidget {
  static String routeName = "/Nav";

  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int index = 0;

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    List<Widget> bodyList = [
      // const HomeScreen(),
      const QrScanScreen(),
      const QrGeneratorScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(child: bodyList[index]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kSecondaryColor,
          unselectedItemColor: Colors.white54,
          currentIndex: index,
          backgroundColor: kPrimaryColor,
          //   fixedColor: Colors.amber,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_scanner,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2),
              label: 'Create',
            ),
          ],
        ),
      ),
    );
  }
}
