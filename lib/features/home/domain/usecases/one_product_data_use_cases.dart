import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class OneProductDataUseCases {
  final ProductRepository repository;

  OneProductDataUseCases(this.repository);

  Future<Either<Failures, ProductDataModel>> call(int id) async {
    return await repository.getOneProductData(id);
  }
}
