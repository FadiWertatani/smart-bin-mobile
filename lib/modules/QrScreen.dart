import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smar_bin/services/SharedPrefsHelper.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {

  String? userCode; // Holds the loaded user code
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadUserCode(); // Load user code on screen initialization
    print("USER CODE: "+userCode.toString());
  }

  Future<void> _loadUserCode() async {
    String? code = await SharedPrefsHelper.getUserCode();
    setState(() {
      userCode = code ?? 'No Code Found'; // Default value if null
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QR Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4), // Added spacing between texts
            Text(
              'Let the camera scan your QR',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Increased from 70 to 80
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 1),
            // QR Code Generation
            QrImageView(
              data: userCode.toString(), // Use the generated unique code
              version: QrVersions.auto,
              size: 220,
            ),
            const SizedBox(height: 16),
            Text(
              'Scan this QR Code',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Spacer(flex: 2),
            // Done button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
