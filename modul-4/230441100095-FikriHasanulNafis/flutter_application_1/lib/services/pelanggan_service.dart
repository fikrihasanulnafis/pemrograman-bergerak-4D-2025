import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/pelanggan_model.dart';

class PelangganService {
  static const String _baseUrl =
      'https://firestore.googleapis.com/v1/projects/pelanggan-f515f/databases/(default)/documents/pelanggan';

  // GET: Ambil semua pelanggan
  Future<List<Pelanggan>> fetchPelanggan() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pelanggan> list = [];
      if (data['documents'] != null) {
        for (var item in data['documents']) {
          list.add(Pelanggan.fromJson(item));
        }
      }
      return list;
    } else {
      throw Exception('Failed to load pelanggan');
    }
  }

  // POST: Tambah pelanggan baru
  Future<void> addPelanggan(Pelanggan pelanggan) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pelanggan.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add pelanggan');
    }
  }

  // PATCH: Update pelanggan
  Future<void> updatePelanggan(String documentPath, Pelanggan pelanggan) async {
    final response = await http.patch(
      Uri.parse(documentPath),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pelanggan.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pelanggan');
    }
  }

  // DELETE: Hapus pelanggan berdasarkan path lengkap dokumen
  Future<void> deletePelanggan(String documentPath) async {
    final response = await http.delete(Uri.parse(documentPath));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete pelanggan');
    }
  }
}
