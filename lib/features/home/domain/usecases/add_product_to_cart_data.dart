import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class AddProductToCartAccountData {
  final ProductRepository repository;

  AddProductToCartAccountData(this.repository);

  Future<Either<Failures, bool>> call(ProductData data) async {
    return await repository.addProductToCartAccount(data);
  }
}
