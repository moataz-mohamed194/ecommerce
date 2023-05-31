import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasouces/home_remote_data_source.dart';
import '../models/product_model.dart';

class productRepositoriesImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  productRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, List<ProductDataModel>>> getAllProductData() async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount = await remoteDataSource.getProductAccount();
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, ProductDataModel>> getOneProductData(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount = await remoteDataSource.getProductDataAccount(id);
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, bool>> deleteOneProductData(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.deleteProductDataAccount(id);
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List>> getAllCategoryData() async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.getAllCategories();
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<ProductDataModel>>> getProductSearchData(bool? sort, String? limit, String? category) async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.getProductSearchCategories(sort, limit, category);
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, bool>> addProductToCartAccount(ProductData data) async {
    final ProductDataModel dataModel = ProductDataModel(
        title: data.title.toString(),
        image: data.image.toString(),
        description: data.description.toString(),
        price: data.price,
        id: data.id,
        category: data.category.toString());
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
        await remoteDataSource.addProductToCartAccount(dataModel);
        return Right(currentAccount);
      } on OfflineException {
        return Left(OfflineFailures());
      } on CheckDataException {
        return Left(CheckDataFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

}
