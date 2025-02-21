import 'package:flutter/material.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'QR Code',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 1),
            // QR Code Image
            Container(
              width: 220,
              height: 220,
              child: Image.asset(
                'assets/images/qr_code.png',
                // color: const Color(0xFF5EACC1),
                fit: BoxFit.contain,
              ),
              // Alternative: If you're loading from network
              // child: Image.network(
              //   'https://your-api.com/qr-codes/your-unique-code',
              //   color: const Color(0xFF5EACC1),
              //   fit: BoxFit.contain,
              // ),
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
                    backgroundColor: const Color(0xFF5EACC1),
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