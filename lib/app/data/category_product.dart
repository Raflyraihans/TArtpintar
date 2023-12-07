class CategoryProduct {
  int? id;
  int? rukunTetanggaId;
  String? category;
  String? createdAt;
  String? updatedAt;

  CategoryProduct(
      {this.id,
      this.rukunTetanggaId,
      this.category,
      this.createdAt,
      this.updatedAt});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rukunTetanggaId = json['rukun_tetangga_id'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rukun_tetangga_id'] = rukunTetanggaId;
    data['category'] = category;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
