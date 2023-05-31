import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/sql/sql_tables.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductDataModel>> getProductAccount();
  Future<ProductDataModel> getProductDataAccount(int id);
  Future<bool> deleteProductDataAccount(int id);
  Future<List> getAllCategories();
  Future<List<ProductDataModel>> getProductSearchCategories(bool? sort, String? limit, String? category);
  Future<bool> addProductToCartAccount(ProductData data);
}

class ProductRemoteDataSourceImple extends ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImple({required this.client});

  @override
  Future<List<ProductDataModel>> getProductAccount() async {
    try {
      final response = await client.get(Uri.parse(EndPoints.getAllProductsUrl));
      if (response.statusCode == 200) {
        final List<ProductDataModel> dataModels = json
            .decode(response.body)
            .map<ProductDataModel>(
                (jsonCitiesModel) => ProductDataModel.fromJson(jsonCitiesModel))
            .toList();
        return dataModels;
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }

  @override
  Future<ProductDataModel> getProductDataAccount(int id) async {
    try {
      final response = await client.get(Uri.parse(EndPoints.getOneProduct(id)));
      if (response.statusCode == 200) {
        final ProductDataModel dataModels =
            ProductDataModel.fromJson(json.decode(response.body));
        return dataModels;
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }

  @override
  Future<bool> deleteProductDataAccount(int id) async {
    try {
      final response =
          await client.get(Uri.parse(EndPoints.deleteOneProductsUrl(id)));
      if (response.statusCode == 200) {
        ProductDataModel.fromJson(json.decode(response.body));
        return true;
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }

  @override
  Future<List> getAllCategories() async {
    try {
      final response =
          await client.get(Uri.parse(EndPoints.getAllCategoryUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }

  @override
  Future<List<ProductDataModel>> getProductSearchCategories(bool? sort, String? limit, String? category) async {
    try {
      String link = EndPoints.getAllProductsUrl;
      if (category != null){
        link = "${EndPoints.getAllProductSearchUrl}/$category";
      }
      if (sort == true){
        link = '$link?sort=desc';
      }
      if (limit != null){
        if (sort == true){
          link = '$link&limit=$limit';
        }else{
          link = '$link?limit=$limit';

        }
      }
      final response = await client.get(Uri.parse(link));
      if (response.statusCode == 200) {
        final List<ProductDataModel> dataModels = json
            .decode(response.body)
            .map<ProductDataModel>(
                (jsonCitiesModel) => ProductDataModel.fromJson(jsonCitiesModel))
            .toList();
        return dataModels;
      } else if (response.statusCode == 401) {
        throw CheckDataException();
      } else {
        throw OfflineException();
      }
    } catch (e) {
      if (e is CheckDataException) {
        throw CheckDataException();
      }
      throw OfflineException();
    }
  }


  @override
  Future<bool> addProductToCartAccount(ProductData data) async {
    final db = await SqlTables().createTables();
    try{
      var x = await db.insert(
        'Cart',
        {
          'title': data.title,
          "price": data.price,
          "count": 1,
          "userId": 2,
          "idProduct":data.id,
          "image": data.image,
        },
      );

      return true;
    }catch(e){
      throw OfflineException();

    }
  }


}
