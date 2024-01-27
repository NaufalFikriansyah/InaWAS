import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aplikasi InaWAS merupakan aplikasi mobile untuk memberikan peringatan adanya cuaca ekstrem di wilayah Banten berbasis Kecamatan menggunakan konsep Geolocation dan Crowdsourcing'),

          ],
        ),
      ),
    );
  }
}