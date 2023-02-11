import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class QrScanScreen extends StatefulWidget {
  static String routeName = "/qrscan";

  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  late Size size;
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? _controller;
  bool isFlashOff = true;
  Barcode? result;
  bool isBuild = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (!isBuild && _controller != null) {
      _controller?.pauseCamera();
      _controller?.resumeCamera();
      setState(() {
        isBuild = true;
      });
    }

    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 40,
              color: kPrimaryColor,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    color: kPrimaryColor,
                    child: InkWell(
                      highlightColor: kPrimaryColor,
                      onTap: () async {
                        setState(() {
                          isFlashOff = !isFlashOff;
                        });
                        _controller?.toggleFlash();
                      },
                      child: Icon(
                        isFlashOff ? Icons.flash_on : Icons.flash_off,
                        size: 24,
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  Material(
                    color: kPrimaryColor,
                    child: InkWell(
                      onTap: () {
                        setState(() {});
                        _controller?.flipCamera();
                      },
                      child: const Icon(
                        Icons.flip_camera_ios_outlined,
                        size: 24,
                        color: kSecondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(flex: 9, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 250.0;
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRviewCreated,
      onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
        cutOutSize: scanArea,
        borderWidth: 10,
        borderColor: kPrimaryColor,
        borderLength: 20,
        borderRadius: 4,
      ),
    );
  }

  Widget _showResult() {
    bool _validUrl = Uri.parse(result!.code.toString()).isAbsolute;
    return Center(
        child: FutureBuilder<dynamic>(
      future: showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              child: AlertDialog(
                title: const Text(
                  'Scan Result',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _validUrl
                          ? SelectableText.rich(TextSpan(
                              text: result!.code.toString(),
                              style: const TextStyle(color: kPrimaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchUrl(Uri.parse(result!.code.toString()));
                                }))
                          : Text(
                              result!.code.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _controller?.resumeCamera();
                        },
                        child: const Text(
                          'Close',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onWillPop: () async => false,
            );
          }),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        throw UnimplementedError;
      },
    ));
  }

  void _onQRviewCreated(QRViewController _qrController) {
    setState(() {
      this._controller = _qrController;
    });
    _controller?.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });
      if (result?.code != null) {
        print('Scanned & showing result');
        _showResult();
      }
    });
  }

  void onPermissionSet(
      BuildContext context, QRViewController _ctrl, bool _permisson) {
    if (!_permisson) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Permision')));
    }
  }
}
