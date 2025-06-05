import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/pelanggan_rest_api_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Pelanggan',
      home: PelangganRestApiScreen(),  // Ganti dengan widget Anda
    );
  }
}
