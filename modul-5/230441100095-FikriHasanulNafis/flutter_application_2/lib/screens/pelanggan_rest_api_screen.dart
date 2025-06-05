import 'package:flutter/material.dart';
import '../models/pelanggan.dart';
import '../services/api_service.dart';

class PelangganRestApiScreen extends StatefulWidget {
  const PelangganRestApiScreen({Key? key}) : super(key: key);

  @override
  _PelangganRestApiScreenState createState() => _PelangganRestApiScreenState();
}

class _PelangganRestApiScreenState extends State<PelangganRestApiScreen> {
  final ApiService api = ApiService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  String? _editId;
  bool _loading = false;
  Future<List<Pelanggan>>? _futurePelanggan;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _futurePelanggan = api.fetchPelanggan().then((list) {
        print('Data pelanggan dari API:');
        for (var p in list) {
          print('id: ${p.id}, nama: ${p.nama}, email: ${p.email}, noHp: ${p.noHp}');
        }
        return list;
      });
    });
  }

  void _clear() {
    _editId = null;
    _nameCtrl.clear();
    _emailCtrl.clear();
    _phoneCtrl.clear();
    setState(() {});
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final pelanggan = Pelanggan(
      id: _editId ?? '',
      nama: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      noHp: _phoneCtrl.text.trim(),
    );

    try {
      if (_editId == null) {
        await api.addPelanggan(pelanggan);
      } else {
        await api.updatePelanggan(pelanggan);
      }
      _clear();
      _refreshData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_editId == null ? 'Berhasil menambah pelanggan' : 'Berhasil memperbarui pelanggan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _delete(String id) async {
    setState(() => _loading = true);
    try {
      await api.deletePelanggan(id);
      if (_editId == id) _clear();
      _refreshData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil menghapus pelanggan')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName harus diisi';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email harus diisi';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email tidak valid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Pelanggan')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) => _validateNotEmpty(value, 'Nama'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneCtrl,
                        decoration: const InputDecoration(
                          labelText: 'No HP',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => _validateNotEmpty(value, 'No HP'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _loading ? null : _save,
                              icon: Icon(_editId == null ? Icons.add : Icons.save),
                              label: Text(_editId == null ? 'Tambah' : 'Update'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _loading ? null : _clear,
                              icon: const Icon(Icons.clear),
                              label: const Text('Batal'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 8),
                SizedBox(
                  height: 400,
                  child: FutureBuilder<List<Pelanggan>>(
                    future: _futurePelanggan,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      final pelangganList = snapshot.data ?? [];
                      if (pelangganList.isEmpty) {
                        return const Center(child: Text('Belum ada data'));
                      }

                      return ListView.separated(
                        itemCount: pelangganList.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = pelangganList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(item.nama.isNotEmpty ? item.nama[0].toUpperCase() : '?'),
                            ),
                            title: Text(item.nama.isNotEmpty ? item.nama : '(Nama kosong)'),
                            subtitle: Text(item.email.isNotEmpty ? item.email : '-'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    setState(() {
                                      _editId = item.id;
                                      _nameCtrl.text = item.nama;
                                      _emailCtrl.text = item.email;
                                      _phoneCtrl.text = item.noHp;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _delete(item.id),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
