class Barang {
  int? id;
  String? name;
  int? categoryId;
  String? image;
  String? imagePath;
  int? harga;
  String? deskripsi;
  int? stock;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool fav = false;
  // Category? category;

  Barang(
      {this.id,
      this.name,
      this.categoryId,
      this.image,
      this.imagePath,
      this.harga,
      this.deskripsi,
      this.stock,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.fav = false
      // this.category,
      });

  Barang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    image = json['image'];
    imagePath = json['image_path'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    // fav = false;
    // category = json['category'] != null
    //     ? new Category.fromJson(json['category'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['image_path'] = this.imagePath;
    data['harga'] = this.harga;
    data['deskripsi'] = this.deskripsi;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['fav'] = this.fav;
    // if (this.category != null) {
    //   data['category'] = this.category!.toJson();
    // }
    return data;
  }
}

class CategoryBarang {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  CategoryBarang(
      {this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  CategoryBarang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
