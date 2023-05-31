import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../repositories/add_product_repository.dart';

class UpdateProductFromCartAccountData {
  final AddProductRepository repository;

  UpdateProductFromCartAccountData(this.repository);

  Future<Either<Failures, List<ProductDataModel>>> call(int index, int newCount) async {
    return await repository.updateProductToCartAccount(index, newCount);
  }
}
