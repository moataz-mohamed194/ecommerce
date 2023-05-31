import 'package:dartz/dartz.dart';

import '../../../../core/error/Failures.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';
import '../repositories/home_repository.dart';

class DeleteOneProductUseCases {
  final ProductRepository repository;

  DeleteOneProductUseCases(this.repository);

  Future<Either<Failures, bool>> call(int id) async {
    return await repository.deleteOneProductData(id);
  }
}
