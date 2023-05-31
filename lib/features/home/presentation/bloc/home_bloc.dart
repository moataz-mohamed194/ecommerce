import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/Failures.dart';
import '../../../../core/error/failures_message.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product_to_cart_data.dart';
import '../../domain/usecases/delete_one_product_use_cases.dart';
import '../../domain/usecases/get_all_categories_data_use_cases.dart';
import '../../domain/usecases/get_products_search_data_use_cases.dart';
import '../../domain/usecases/home_data_use_cases.dart';
import '../../domain/usecases/one_product_data_use_cases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductDataUseCases getProductData;
  final OneProductDataUseCases getOneProductData;
  final DeleteOneProductUseCases deleteOneProductData;
  final GetAllCategoriesDataUseCases getAllCategories;
  final GetProductsSearchDataUseCases getProductSearchData;
  final AddProductToCartAccountData addToCart;

  HomeBloc(
      {required this.getProductData,
      required this.getOneProductData,
        required this.getAllCategories,
        required this.getProductSearchData,
   required this.addToCart,
      required this.deleteOneProductData})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetHomeEvent) {
        emit(LoadingHomeState());
        final failureOrDoneMessage = await getProductData();
        final failureOrDoneMessage2 = await getAllCategories();
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage, failureOrDoneMessage2));
      }else if (event is GetSearchProductEvent) {
        emit(LoadingHomeState());
        final failureOrDoneMessage = await getProductSearchData(event.sort, event.limit, event.category);
        final failureOrDoneMessage2 = await getAllCategories();
        emit(_mapFailureOrPostsToStateForGet2(failureOrDoneMessage, failureOrDoneMessage2));
        emit(state);

      }else if (event is GetOneProductEvent) {
        emit(LoadingHomeState());
        final failureOrDoneMessage = await getOneProductData(event.id!);
        emit(_mapFailureOrOnePostsToStateForGet(failureOrDoneMessage));
      }else if (event is DeleteOneProductEvent) {
        emit(LoadingHomeState());
        final failureOrDoneMessage = await deleteOneProductData(event.id!);
        emit(_mapFailureOrPostsToDeleteStateForGet(failureOrDoneMessage));
      }
      else if (event is AddProductToCartEvent) {
        emit(LoadingHomeState());
        final failureOrDoneMessage = await addToCart(event.data);
        emit(failureOrDoneMessage.fold(
              (failure) => ErrorCartHomeState(message: _mapFailureToMessage(failure)),
              (data) => AddedToCartProductAccountState(data: data),
        ));

      }
    });
  }
}

HomeState _mapFailureOrPostsToStateForGet(
    Either<Failures, List<ProductData>> either,
    Either<Failures, List> either2) {
  var x = either2.fold((fa) => _mapFailureToMessage(fa), (ar) => ar);
  return either.fold(
    (failure) => ErrorHomeState(message: _mapFailureToMessage(failure)),
    (data) => LoadedHomeState(data: data,
        dataCategory: x.runtimeType.toString() == 'List<dynamic>'
            ? x as List<dynamic>
            : [],),
  );
}
HomeState _mapFailureOrPostsToStateForGet2(
    Either<Failures, List<ProductData>> either,
    Either<Failures, List> either2) {
  var x = either2.fold((fa) => _mapFailureToMessage(fa), (ar) => ar);
  return either.fold(
        (failure) => ErrorHomeState0(message: _mapFailureToMessage(failure)),
        (data) => LoadedHomeSearchState(data: data,
      dataCategory: x.runtimeType.toString() == 'List<dynamic>'
          ? x as List<dynamic>
          : [],),
  );
}

HomeState _mapFailureOrPostsToDeleteStateForGet(Either<Failures, bool> either) {
  return either.fold(
    (failure) => ErrorHomeState(message: _mapFailureToMessage(failure)),
    (data) => DeleteProductHomeState(data: data),
  );
}

HomeState _mapFailureOrOnePostsToStateForGet(
    Either<Failures, ProductData> either) {
  return either.fold(
    (failure) => ErrorHomeState(message: _mapFailureToMessage(failure)),
    (data) => LoadedOneProductHomeState(data: data),
  );
}

String _mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case OfflineFailures:
      return SERVER_FAILURE_MESSAGE;
    case CheckDataFailures:
      return LOGIN_FAILURE_MESSAGE;
    case OfflineFailures:
      return OFFLINE_FAILURE_MESSAGE;
    default:
      return "Unexpected Error , Please try again later .";
  }
}
