// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rtkita/app/components/dialog.dart';
import 'package:rtkita/app/data/category_product.dart';
import 'package:rtkita/app/data/product.dart';
import 'package:rtkita/app/modules/home/controllers/home_controller.dart';
import 'package:rtkita/env/global_var.dart';

class UmkmProvider extends GetConnect {
  GetStorage box = GetStorage();
  Future<List<CategoryProduct?>> getListCategory(context) async {
    List<CategoryProduct?> categoryProduct = [];
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await get('$urlApi/kategori-produk',
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      homeController.loadingStatus(false);
      if (data != null) {
        data['category_product']
            .forEach((v) => categoryProduct.add(CategoryProduct.fromJson(v)));
      }
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
    return categoryProduct;
  }

  Future<List<Product?>> getProductByCategory(context, categoryId) async {
    List<Product?> product = [];
    HomeController homeController = Get.put(HomeController());

    try {
      homeController.loadingStatus(true);
      final response = await get(
          '$urlApi/produk?category_product_id=$categoryId',
          headers: {'Authorization': 'Bearer ' + box.read('token')});
      var data = json.decode(response.bodyString.toString());
      homeController.loadingStatus(false);
      if (data != null) {
        if (data['product'] != null) {
          data['product'].forEach((v) => product.add(Product.fromJson(v)));
        }
      }
    } catch (e) {
      homeController.loadingStatus(false);
      errorMessage(e);
    }
    return product;
  }
}
