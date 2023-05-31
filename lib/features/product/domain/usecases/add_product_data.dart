import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/add_product_repository.dart';

class AddProductAccountData {
  final AddProductRepository repository;

  AddProductAccountData(this.repository);

  Future<Either<Failures, ProductDataModel>> call(ProductData data) async {
    return await repository.AddProductData(data);
  }
}
