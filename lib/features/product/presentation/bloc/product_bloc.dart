import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/Failures.dart';
import '../../../../core/error/failures_message.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/add_product_data.dart';
import '../../../home/domain/usecases/add_product_to_cart_data.dart';
import '../../domain/usecases/delete_product_from_cart_data.dart';
import '../../domain/usecases/edit_product_data.dart';
import '../../domain/usecases/get_product_to_cart_data.dart';

part 'product_event.dart';
part 'product_state.dart';

class AddProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProductAccountData addProduct;
  final EditProductAccountData editProduct;
  final GetProductToCartAccountData getProductCart;
  final DeleteProductFromCartAccountData deleteProduct;
  AddProductBloc({required this.addProduct, required this.editProduct, required this.getProductCart, required this.deleteProduct}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is AddProductEvent) {
        emit(LoadingProductState());
        final failureOrDoneMessage = await addProduct(event.data);
        emit(_mapFailureOrPostsToStateForGet(failureOrDoneMessage));
      }
      else if (event is EditProductEvent) {
        emit(LoadingProductState());
        final failureOrDoneMessage = await editProduct(event.data);
        emit(_mapFailureOrPostsToEditStateForGet(failureOrDoneMessage));

      }
      else if (event is GetProductCartEvent) {
        emit(LoadingProductState());
        final failureOrDoneMessage = await getProductCart();
        emit(failureOrDoneMessage.fold(
              (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
              (data) => LoadedCartProductAccountState(data: data),
        ));

      }
      else if (event is DeleteProductCartEvent) {
        emit(LoadingProductState());
        final failureOrDoneMessage = await deleteProduct(event.id);

        emit(failureOrDoneMessage.fold(
              (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
              (data) => LoadedCartProductAccountState(data: data),
        ));
      }

    });
  }
}

ProductState _mapFailureOrPostsToEditStateForGet(
    Either<Failures, ProductData> either) {
  return either.fold(
        (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
        (data) => MessageEditProductAccountState(data: data),
  );
}


ProductState _mapFailureOrPostsToStateForGet(
    Either<Failures, ProductData> either) {
  return either.fold(
        (failure) => ErrorProductState(message: _mapFailureToMessage(failure)),
        (data) => MessageProductAccountState(data: data),
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
