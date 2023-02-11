import 'package:flutter/widgets.dart';
import 'package:qr_scanner_generator/screens/HomeScreen/bottom_nav.dart';
import 'package:qr_scanner_generator/screens/QrGenerator/qr_generator_screen.dart';
import 'package:qr_scanner_generator/screens/QrScanScreen/qr_scan_screen.dart';
import 'package:qr_scanner_generator/screens/splash/splash.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => const Splash(),
  QrScanScreen.routeName: (context) => const QrScanScreen(),
  QrGeneratorScreen.routeName: (context) => const QrGeneratorScreen(),
  BottomNav.routeName: (context) => const BottomNav(),
};
