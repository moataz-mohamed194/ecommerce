import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../repositories/add_product_repository.dart';

class GetProductToCartAccountData {
  final AddProductRepository repository;

  GetProductToCartAccountData(this.repository);

  Future<Either<Failures, List<ProductDataModel>>> call() async {
    return await repository.getProductToCartAccount();
  }
}
