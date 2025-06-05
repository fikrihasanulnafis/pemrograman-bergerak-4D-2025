class Pelanggan {
  final String id;
  final String nama;
  final String email;
  final String noHp;

  Pelanggan({
    required this.id,
    required this.nama,
    required this.email,
    required this.noHp,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: json['id'].toString(),
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      noHp: json['no_hp'] ?? '',
    );
  }
}
