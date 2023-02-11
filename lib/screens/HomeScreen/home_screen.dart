// import 'package:flutter/material.dart';
// import 'package:qr_scanner_generator/constants/constants.dart';
// import 'package:qr_scanner_generator/screens/QrGenerator/qr_generator_screen.dart';
// import 'package:qr_scanner_generator/screens/QrScanScreen/qr_scan_screen.dart';

// class HomeScreen extends StatefulWidget {
//   static String routeName = "/home";
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Size size;
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: const Text(
//           'Qr scanner',
//           style: TextStyle(fontSize: 30),
//         ),
//         centerTitle: true,
//         leading: const Icon(
//           Icons.qr_code_rounded,
//           size: 50,
//         ),
//       ),
//       body: Container(
//         color: kSecondaryColor,
//         height: size.height,
//         width: size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 200,
//               height: 40,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, QrScanScreen.routeName);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: kPrimaryColor,
//                   textStyle: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                   shape: const BeveledRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//                 child: const Text('Scan QR code'),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: 200,
//               height: 40,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, QrGeneratorScreen.routeName);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: kPrimaryColor,
//                   textStyle: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                   shape: const BeveledRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//                 child: const Text('Generate QR code'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
