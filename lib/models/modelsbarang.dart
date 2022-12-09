class Barang {
  final int id, harga, stock;
  final String name, deskripsi, image;

  const Barang(
      {required this.id,
      required this.stock,
      required this.harga,
      required this.name,
      required this.deskripsi,
      required this.image});
  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      id: json['id'],
      stock: json['stock'],
      harga: json['harga'],
      name: json['name'],
      deskripsi: json['deskripsi'],
      image: json['image'],
    );
  }
}
