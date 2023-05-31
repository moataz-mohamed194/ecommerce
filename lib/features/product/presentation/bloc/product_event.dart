part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductEvent {
  final ProductData data;

  AddProductEvent({required this.data});

  @override
  List<Object> get props => [data];
}
class EditProductEvent extends ProductEvent {
  final ProductData data;

  EditProductEvent({required this.data});

  @override
  List<Object> get props => [data];
}
class GetProductCartEvent extends ProductEvent {

  GetProductCartEvent();

  @override
  List<Object> get props => [];
}
class DeleteProductCartEvent extends ProductEvent {
  final int id;
  DeleteProductCartEvent({required this.id});

  @override
  List<Object> get props => [id];
}
