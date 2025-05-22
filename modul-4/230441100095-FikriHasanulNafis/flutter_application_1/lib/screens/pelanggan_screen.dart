// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/pelanggan_model.dart';
// import 'package:flutter_application_1/services/pelanggan_service.dart';

// class PelangganScreen extends StatefulWidget {
//   @override
//   _PelangganScreenState createState() => _PelangganScreenState();
// }

// class _PelangganScreenState extends State<PelangganScreen> {
//   final PelangganService pelangganService = PelangganService();
//   List<Pelanggan> pelangganList = [];

//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController noHpController = TextEditingController();

//   String? editingId;

//   @override
//   void initState() {
//     super.initState();
//     _loadPelanggan();
//   }

//   Future<void> _loadPelanggan() async {
//     final data = await pelangganService.fetchPelanggan();
//     setState(() {
//       pelangganList = data;
//     });
//   }

//   // Fungsi untuk menambahkan pelanggan baru
//   Future<void> _addPelanggan() async {
//     final newPelanggan = Pelanggan(
//       id: '', // ID akan digenerate oleh Firestore
//       nama: namaController.text,
//       email: emailController.text,
//       noHp: noHpController.text,
//     );
    
//     await pelangganService.addPelanggan(newPelanggan);
//     _loadPelanggan(); // Refresh daftar pelanggan
//     _clearForm();
//   }

//   // Fungsi untuk mengedit pelanggan
//   Future<void> _updatePelanggan() async {
//     if (editingId != null) {
//       final url = 'https://firestore.googleapis.com/v1/$editingId'; // Perbaiki URL untuk update
//       final updatedPelanggan = Pelanggan(
//         id: editingId!,
//         nama: namaController.text,
//         email: emailController.text,
//         noHp: noHpController.text,
//       );
//       print('🟡 Update pelanggan di path: $url');
//       await pelangganService.updatePelanggan(url, updatedPelanggan);
//       _loadPelanggan(); // Refresh daftar pelanggan
//       _clearForm();
//     }
//   }

//   // Fungsi untuk menghapus pelanggan
//   Future<void> _deletePelanggan(String id) async {
//     final url = 'https://firestore.googleapis.com/v1/$id'; // Perbaiki URL untuk delete
//     print('🔴 Hapus pelanggan dengan path: $url');
//     await pelangganService.deletePelanggan(url);
//     _loadPelanggan(); // Refresh daftar pelanggan
//   }

//   // Fungsi untuk membersihkan form
//   void _clearForm() {
//     namaController.clear();
//     emailController.clear();
//     noHpController.clear();
//     editingId = null;
//   }

//   // Fungsi untuk membuka form edit
//   void _editPelanggan(Pelanggan pelanggan) {
//     setState(() {
//       editingId = pelanggan.id;
//       namaController.text = pelanggan.nama;
//       emailController.text = pelanggan.email;
//       noHpController.text = pelanggan.noHp;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Daftar Pelanggan")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Form input untuk tambah/edit pelanggan
//             TextField(
//               controller: namaController,
//               decoration: InputDecoration(labelText: 'Nama'),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: noHpController,
//               decoration: InputDecoration(labelText: 'No HP'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: editingId == null ? _addPelanggan : _updatePelanggan,
//               child: Text(editingId == null ? 'Tambah Pelanggan' : 'Perbarui Pelanggan'),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: pelangganList.length,
//                 itemBuilder: (context, index) {
//                   final pelanggan = pelangganList[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text(pelanggan.nama),
//                       subtitle: Text("Email: ${pelanggan.email}, NoHP: ${pelanggan.noHp}"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () => _editPelanggan(pelanggan), // Edit data pelanggan
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.delete),
//                             onPressed: () => _deletePelanggan(pelanggan.id), // Hapus data pelanggan
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pelanggan_model.dart';
import 'package:flutter_application_1/services/pelanggan_service.dart';

class PelangganScreen extends StatefulWidget {
  @override
  _PelangganScreenState createState() => _PelangganScreenState();
}

class _PelangganScreenState extends State<PelangganScreen> {
  final PelangganService pelangganService = PelangganService();
  List<Pelanggan> pelangganList = [];

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();

  String? editingId;

  @override
  void initState() {
    super.initState();
    _loadPelanggan();
  }

  Future<void> _loadPelanggan() async {
    final data = await pelangganService.fetchPelanggan();
    setState(() {
      pelangganList = data;
    });
  }

  Future<void> _addPelanggan() async {
    final newPelanggan = Pelanggan(
      id: '',
      nama: namaController.text,
      email: emailController.text,
      noHp: noHpController.text,
    );
    await pelangganService.addPelanggan(newPelanggan);
    _loadPelanggan();
    _clearForm();
  }

  Future<void> _updatePelanggan() async {
    if (editingId != null) {
      final url = 'https://firestore.googleapis.com/v1/$editingId';
      final updatedPelanggan = Pelanggan(
        id: editingId!,
        nama: namaController.text,
        email: emailController.text,
        noHp: noHpController.text,
      );
      await pelangganService.updatePelanggan(url, updatedPelanggan);
      _loadPelanggan();
      _clearForm();
    }
  }

  Future<void> _deletePelanggan(String id) async {
    final url = 'https://firestore.googleapis.com/v1/$id';
    await pelangganService.deletePelanggan(url);
    _loadPelanggan();
  }

  void _clearForm() {
    namaController.clear();
    emailController.clear();
    noHpController.clear();
    editingId = null;
  }

  void _editPelanggan(Pelanggan pelanggan) {
    setState(() {
      editingId = pelanggan.id;
      namaController.text = pelanggan.nama;
      emailController.text = pelanggan.email;
      noHpController.text = pelanggan.noHp;
    });
  }

  @override
  @override
Widget build(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  return Scaffold(
    appBar: AppBar(title: Text("Daftar Pelanggan")),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey, // Tambahkan GlobalKey pada Form
        child: Column(
          children: [
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: noHpController,
              decoration: InputDecoration(labelText: 'No HP', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No HP tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Jika validasi lolos, lanjutkan proses tambah atau update
                  if (editingId == null) {
                    _addPelanggan();
                  } else {
                    _updatePelanggan();
                  }
                }
              },
              child: Text(editingId == null ? 'Tambah Pelanggan' : 'Perbarui Pelanggan'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: pelangganList.length,
                itemBuilder: (context, index) {
                  final pelanggan = pelangganList[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(pelanggan.nama, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Email: ${pelanggan.email}\nNo HP: ${pelanggan.noHp}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _editPelanggan(pelanggan),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deletePelanggan(pelanggan.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
