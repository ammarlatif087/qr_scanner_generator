import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/constants.dart';

class QrGeneratorScreen extends StatefulWidget {
  static String routeName = "/qrgenerator";

  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            child: QrImage(
              data: _controller.text,
              size: min(MediaQuery.of(context).size.width / 1.3,
                  MediaQuery.of(context).size.height / 1.8),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildTextBuildForQr(context),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    if (_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter some data..')));
                    } else {
                      _qrDownload(_controller.text);
                    }
                  },
                  minWidth: 50,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: kPrimaryColor,
                  child: const Icon(
                    Icons.save_alt,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                MaterialButton(
                    onPressed: () {
                      _qrShare(_controller.text);
                    },
                    minWidth: 50,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: kPrimaryColor,
                    child: const Icon(
                      Icons.share,
                      size: 40,
                      color: Colors.white,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTextBuildForQr(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: _controller,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          decoration: InputDecoration(
              hintText: 'Enter Data..',
              hintStyle: const TextStyle(
                color: Colors.black26,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.done,
                    color: kPrimaryColor,
                  ))),
        ),
      ),
    );
  }

  _qrCode(String _txt) async {
    final qrValidationResult = QrValidator.validate(
      data: _txt,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    qrValidationResult.status = QrValidationStatus.valid;
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode!,
      color: Colors.green,
      embeddedImageStyle: null,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.circle,
        color: kPrimaryColor,
      ),
      emptyColor: Colors.black,
      gapless: true,
    );
    Directory _tempDir = await getTemporaryDirectory();
    String _tempPath = _tempDir.path;
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    String finalPath = '$_tempPath/$time.png';
    final picData =
        await painter.toImageData(2048, format: ImageByteFormat.png);
    writeToFile(picData!, finalPath);
    return finalPath;
  }

  Future<String?> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
      buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      ),
    );
  }

  _qrDownload(String _path) async {
    String _filePath = await _qrCode(_path);
    String albumName = 'Qr codes';
    final _success =
        await GallerySaver.saveImage(_filePath, albumName: albumName);
    if (_success != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('saved..')));
    }
  }

  _qrShare(String _path) async {
    String _filePath = await _qrCode(_path);
    await Share.shareFiles([_filePath],
        mimeTypes: ["image/png"], subject: 'My QR code', text: 'Scan me');
  }
}
