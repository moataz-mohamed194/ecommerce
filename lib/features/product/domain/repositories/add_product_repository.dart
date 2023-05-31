import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

abstract class AddProductRepository {
  Future<Either<Failures, ProductDataModel>> AddProductData(ProductData data);
  Future<Either<Failures, ProductDataModel>> EditProductData(ProductData data);
  Future<Either<Failures, List<ProductDataModel>>> getProductToCartAccount();
  Future<Either<Failures, List<ProductDataModel>>> deleteProductToCartAccount(int index);
  Future<Either<Failures, List<ProductDataModel>>> updateProductToCartAccount(int index, int newCount);
}
