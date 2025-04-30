import 'dart:typed_data';
import 'package:flutter/material.dart';

class DetailWisataPage extends StatelessWidget {
  final String namaWisata;
  final String jenis;
  final String lokasi;
  final String harga;
  final String deskripsi;
  final Uint8List? imageBytes;

  const DetailWisataPage({
    Key? key,
    required this.namaWisata,
    required this.jenis,
    required this.lokasi,
    required this.harga,
    required this.deskripsi,
    this.imageBytes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          namaWisata,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (imageBytes != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  imageBytes!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            // Row for Jenis Wisata and Harga Tiket
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.landscape, color: Colors.grey[700], size: 20),
                    SizedBox(width: 6),
                    Text(jenis),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.confirmation_number_outlined, color: Colors.grey[700]),
                    SizedBox(width: 6),
                    Text(
                      harga,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[700], size: 20),
                SizedBox(width: 6),
                Text(lokasi),
              ],
            ),
            SizedBox(height: 12),
            Text(
              deskripsi,
              style: TextStyle(fontSize: 15, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
