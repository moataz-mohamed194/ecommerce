import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class GetAllCategoriesDataUseCases {
  final ProductRepository repository;

  GetAllCategoriesDataUseCases(this.repository);

  Future<Either<Failures, List>> call() async {
    return await repository.getAllCategoryData();
  }
}
