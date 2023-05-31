import 'package:dartz/dartz.dart';
import '../../../../core/error/Failures.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/add_product_repository.dart';
import '../datasouces/add_product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoriesImpl implements AddProductRepository {
  final AddProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, ProductDataModel>> AddProductData(
      ProductData data) async {
    final ProductDataModel dataModel = ProductDataModel(
        title: data.title.toString(),
        image: data.image.toString(),
        description: data.description.toString(),
        price: data.price,
        category: data.category.toString());
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.addProductAccount(dataModel);
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
  Future<Either<Failures, ProductDataModel>> EditProductData(ProductData data) async {
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
            await remoteDataSource.addProductAccount(dataModel);
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
  Future<Either<Failures, List<ProductDataModel>>> getProductToCartAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
        await remoteDataSource.getProductToCartAccount();
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
  Future<Either<Failures, List<ProductDataModel>>> deleteProductToCartAccount(int index) async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.deleteProductToCartAccount(index);
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
  Future<Either<Failures, List<ProductDataModel>>> updateProductToCartAccount(int index, int newCount) async {
    if (await networkInfo.isConnected) {
      try {
        final currentAccount =
            await remoteDataSource.updateProductToCartAccount(index, newCount);
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
