import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../repositories/add_product_repository.dart';

class DeleteProductFromCartAccountData {
  final AddProductRepository repository;

  DeleteProductFromCartAccountData(this.repository);

  Future<Either<Failures, List<ProductDataModel>>> call(int index) async {
    return await repository.deleteProductToCartAccount(index);
  }
}
