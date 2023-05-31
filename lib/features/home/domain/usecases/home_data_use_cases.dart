import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class ProductDataUseCases {
  final ProductRepository repository;

  ProductDataUseCases(this.repository);

  Future<Either<Failures, List<ProductDataModel>>> call() async {
    return await repository.getAllProductData();
  }
}
