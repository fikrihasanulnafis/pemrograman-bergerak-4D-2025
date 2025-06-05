import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PelangganFirestoreScreen extends StatefulWidget {
  const PelangganFirestoreScreen({Key? key}) : super(key: key);

  @override
  _PelangganFirestoreScreenState createState() => _PelangganFirestoreScreenState();
}

class _PelangganFirestoreScreenState extends State<PelangganFirestoreScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  bool _loading = false;
  String? _editDocId;

  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final data = {
      'nama': _nameCtrl.text,
      'email': _emailCtrl.text,
      'no_hp': _phoneCtrl.text,
    };

    try {
      if (_editDocId == null) {
        await FirebaseFirestore.instance.collection('pelanggan').add(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil menambah data')));
      } else {
        await FirebaseFirestore.instance.collection('pelanggan').doc(_editDocId).update(data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data berhasil diperbarui')));
      }
      _clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _delete(String docId) async {
    setState(() => _loading = true);
    try {
      await FirebaseFirestore.instance.collection('pelanggan').doc(docId).delete();
      if (_editDocId == docId) _clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  void _clear() {
    _editDocId = null;
    _nameCtrl.clear();
    _emailCtrl.clear();
    _phoneCtrl.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelanggan (Firestore)')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(labelText: 'Nama'),
                            validator: (value) => value!.isEmpty ? 'Nama harus diisi' : null,
                          ),
                          TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Email harus diisi';
                              if (!emailRegex.hasMatch(value)) return 'Format email tidak valid';
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _phoneCtrl,
                            decoration: const InputDecoration(labelText: 'No HP'),
                            validator: (value) => value!.isEmpty ? 'No HP harus diisi' : null,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _save,
                                child: Text(_editDocId == null ? 'Tambah' : 'Update'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: _clear,
                                child: const Text('Batal'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Daftar Pelanggan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('pelanggan').snapshots(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snap.hasError) {
                      return Text('Terjadi kesalahan: ${snap.error}');
                    }
                    final docs = snap.data!.docs;
                    if (docs.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Belum ada data pelanggan.'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data() as Map<String, dynamic>;
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(data['nama'] ?? '(Tanpa nama)'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email: ${data['email'] ?? '-'}'),
                                Text('No HP: ${data['no_hp'] ?? '-'}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    setState(() {
                                      _editDocId = docs[i].id;
                                      _nameCtrl.text = data['nama'] ?? '';
                                      _emailCtrl.text = data['email'] ?? '';
                                      _phoneCtrl.text = data['no_hp'] ?? '';
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _delete(docs[i].id),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black38,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
