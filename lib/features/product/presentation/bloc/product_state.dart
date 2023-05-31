part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageProductAccountState extends ProductState {
  final ProductData data;

  MessageProductAccountState({required this.data});

  @override
  List<Object> get props => [data];
}

class MessageEditProductAccountState extends ProductState {
  final ProductData data;

  MessageEditProductAccountState({required this.data});

  @override
  List<Object> get props => [data];
}

class LoadedCartProductAccountState extends ProductState {
  final List<ProductData> data;

  LoadedCartProductAccountState({required this.data});

  @override
  List<Object> get props => [data];
}
class LoadedCartProductAccountState2 extends ProductState {
  final List<ProductData> data;

  LoadedCartProductAccountState2({required this.data});

  @override
  List<Object> get props => [data];
}
