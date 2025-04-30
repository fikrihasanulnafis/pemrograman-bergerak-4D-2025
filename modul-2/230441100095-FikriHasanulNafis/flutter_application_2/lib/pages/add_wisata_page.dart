
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:flutter_application_2/pages/detail_wisata_page.dart';

class AddWisataPage extends StatefulWidget {
  const AddWisataPage({Key? key}) : super(key: key);

  @override
  State<AddWisataPage> createState() => _AddWisataPageState();
}

class _AddWisataPageState extends State<AddWisataPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedJenis;
  Uint8List? _imageBytes;

  // Controllers untuk TextFormField
  final TextEditingController namaController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    lokasiController.dispose();
    hargaController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  // Fungsi untuk memilih gambar
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Wisata'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    image: _imageBytes != null
                        ? DecorationImage(
                            image: MemoryImage(_imageBytes!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageBytes == null
                      ? Icon(Icons.add_photo_alternate, size: 60, color: Colors.grey[600])
                      : null,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 43, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 22),
                  ),
                  child: Text(
                    "Upload Image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                buildTextField("Nama Wisata", controller: namaController),
                buildTextField("Lokasi Wisata", controller: lokasiController),
                Text("Jenis Wisata:"),
                SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: selectedJenis,
                  items: ['Alam', 'Budaya', 'Kuliner']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedJenis = value);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                buildTextField("Harga Tiket", controller: hargaController),
                buildTextField("Deskripsi", maxLines: 3, controller: deskripsiController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final namaWisata = namaController.text;
                      final lokasi = lokasiController.text;
                      final harga = hargaController.text;
                      final deskripsi = deskripsiController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailWisataPage(
                            namaWisata: namaWisata,
                            jenis: selectedJenis ?? '',
                            lokasi: lokasi,
                            harga: harga,
                            deskripsi: deskripsi,
                            imageBytes: _imageBytes,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 43, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 22),
                  ),
                  child: Text("Simpan", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    _formKey.currentState!.reset();
                    setState(() {
                      selectedJenis = null;
                      _imageBytes = null;
                    });
                  },
                  child: Text("Reset"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, {int maxLines = 1, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:"),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (value) => value == null || value.isEmpty ? 'Wajib diisi' : null,
          decoration: InputDecoration(
            hintText: 'Masukkan $label di sini',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
