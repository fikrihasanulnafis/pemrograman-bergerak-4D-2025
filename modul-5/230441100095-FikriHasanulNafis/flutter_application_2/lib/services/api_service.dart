import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pelanggan.dart';

class ApiService {
  final String baseUrl = 'http://localhost/restapi_php';

  Future<List<Pelanggan>> fetchPelanggan() async {
    final resp = await http.get(Uri.parse('$baseUrl/getPelanggan.php'));
    if (resp.statusCode != 200) throw Exception('Load failed');
    final List data = json.decode(resp.body);
    final filteredData =
        data.where((e) => (e['nama'] ?? '').toString().isNotEmpty).toList();
    return filteredData.map((e) => Pelanggan.fromJson(e)).toList();
  }

  Future<String> addPelanggan(Pelanggan p) async {
    final resp = await http.post(
      Uri.parse('$baseUrl/addPelanggan.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama': p.nama, 'email': p.email, 'no_hp': p.noHp}),
    );
    if (resp.statusCode != 200) throw Exception('Create failed');
    return json.decode(resp.body)['insert_id'].toString();
  }

  Future<void> updatePelanggan(Pelanggan p) async {
    final resp = await http.put(
      Uri.parse('$baseUrl/updatePelanggan.php?id=${p.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama': p.nama, 'email': p.email, 'no_hp': p.noHp}),
    );
    if (resp.statusCode != 200) throw Exception('Update failed');
  }

  Future<void> deletePelanggan(String id) async {
    final resp = await http.delete(
      Uri.parse('$baseUrl/deletePelanggan.php?id=$id'),
    );
    if (resp.statusCode != 200) throw Exception('Delete failed');
  }
}
