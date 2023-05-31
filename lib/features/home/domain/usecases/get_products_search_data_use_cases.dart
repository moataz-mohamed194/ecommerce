import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class GetProductsSearchDataUseCases {
  final ProductRepository repository;

  GetProductsSearchDataUseCases(this.repository);

  Future<Either<Failures, List<ProductDataModel>>> call(bool? sort, String? limit, String? category) async {
    return await repository.getProductSearchData(sort, limit, category);
  }
}
