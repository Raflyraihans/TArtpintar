import 'package:rtkita/app/data/category_product.dart';
import 'package:rtkita/app/data/family_member.dart';

class Product {
  int? id;
  int? familyMemberId;
  int? categoryProductId;
  String? title;
  String? description;
  String? price;
  String? picture;
  String? createdAt;
  String? updatedAt;
  FamilyMember? familyMember;
  CategoryProduct? categoryProduct;

  Product(
      {this.id,
      this.familyMemberId,
      this.categoryProductId,
      this.title,
      this.description,
      this.price,
      this.picture,
      this.createdAt,
      this.updatedAt,
      this.familyMember,
      this.categoryProduct});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    familyMemberId = json['family_member_id'];
    categoryProductId = json['category_product_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    familyMember = json['family_member'] != null
        ? FamilyMember.fromJson(json['family_member'])
        : null;
    categoryProduct = json['category_product'] != null
        ? CategoryProduct.fromJson(json['category_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['family_member_id'] = familyMemberId;
    data['category_product_id'] = categoryProductId;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['picture'] = picture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (familyMember != null) {
      data['family_member'] = familyMember!.toJson();
    }
    if (categoryProduct != null) {
      data['category_product'] = categoryProduct!.toJson();
    }
    return data;
  }
}
