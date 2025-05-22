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
    final fields = json['fields'];
    return Pelanggan(
      id: json['name'], // gunakan full document path sebagai id
      nama: fields['nama']['stringValue'],
      email: fields['email']['stringValue'],
      noHp: fields['noHp']['stringValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fields": {
        "nama": {"stringValue": nama},
        "email": {"stringValue": email},
        "noHp": {"stringValue": noHp},
      }
    };
  }
}
