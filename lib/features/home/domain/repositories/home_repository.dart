import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failures, List<ProductDataModel>>> getAllProductData();
  Future<Either<Failures, ProductDataModel>> getOneProductData(int id);
  Future<Either<Failures, bool>> deleteOneProductData(int id);
  Future<Either<Failures, List>> getAllCategoryData();
  Future<Either<Failures, List<ProductDataModel>>> getProductSearchData(bool? sort, String? limit, String? category);
  Future<Either<Failures, bool>> addProductToCartAccount(ProductData data);
}
