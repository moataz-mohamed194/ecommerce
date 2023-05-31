import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/api/end_points.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/sql/sql_tables.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class AddProductRemoteDataSource {
  Future<ProductDataModel> addProductAccount(ProductData data);
  Future<ProductDataModel> editProductAccount(ProductData data);
  Future<List<ProductDataModel>> getProductToCartAccount();
  Future<List<ProductDataModel>> deleteProductToCartAccount(int index);
  Future<List<ProductDataModel>> updateProductToCartAccount(int index, int newCount);
}

class AddProductRemoteDataSourceImple extends AddProductRemoteDataSource {
  final http.Client client;

  AddProductRemoteDataSourceImple({required this.client});

  @override
  Future<ProductDataModel> addProductAccount(ProductData data) async {
    try {
    final response =
        await client.post(Uri.parse(EndPoints.getAllProductsUrl), headers: {
      'Accept': 'application/json',
    }, body: {
      "title": data.title,
      "description": data.description,
      'price': data.price,
      'category': data.category,
      'image': data.image
    });
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
  Future<ProductDataModel> editProductAccount(ProductData data) async {
    try {

      final response =
          await client.post(Uri.parse(EndPoints.editOneProductsUrl(data.id!)), headers: {
        'Accept': 'application/json',
      }, body: {
        "title": data.title,
        "description": data.description,
        'price': data.price,
        'category': data.category,
        'image': data.image
      });
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
  Future<List<ProductDataModel>> getProductToCartAccount() async {
    final db = await SqlTables().createTables();
    try{
      final List<Map<String, dynamic>> maps = await db.query('Cart');
      final List<ProductDataModel> dataModels = maps
          .map<ProductDataModel>(
              (jsonCitiesModel) => ProductDataModel.fromJson(jsonCitiesModel))
          .toList();
      return dataModels;
    }catch(e){
    throw OfflineException();

    }
  }

  @override
  Future<List<ProductDataModel>> deleteProductToCartAccount(int index) async {
    final db = await SqlTables().createTables();
    try{
      await db.delete(
        'Cart',
        where: 'id = ?',
        whereArgs: [index],
      );
      final List<Map<String, dynamic>> maps = await db.query('Cart');
      final List<ProductDataModel> dataModels = maps
          .map<ProductDataModel>(
              (jsonCitiesModel) => ProductDataModel.fromJson(jsonCitiesModel))
          .toList();
      return dataModels;
    }catch(e){
      print(e);
      throw OfflineException();

    }
  }

  @override
  Future<List<ProductDataModel>> updateProductToCartAccount(int index, int newCount) async {
    final db = await SqlTables().createTables();
    try{
      await db.update(
        'Cart',
        {'count':newCount},
        where: 'id = ?',
        whereArgs: [index],
      );
      final List<Map<String, dynamic>> maps = await db.query('Cart');
      final List<ProductDataModel> dataModels = maps
          .map<ProductDataModel>(
              (jsonCitiesModel) => ProductDataModel.fromJson(jsonCitiesModel))
          .toList();
      return dataModels;
    }catch(e){
      print(e);
      throw OfflineException();

    }
  }
}
