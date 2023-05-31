import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/add_product_repository.dart';

class EditProductAccountData {
  final AddProductRepository repository;

  EditProductAccountData(this.repository);

  Future<Either<Failures, ProductDataModel>> call(ProductData data) async {
    return await repository.EditProductData(data);
  }
}
