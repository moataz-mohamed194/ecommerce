part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeEvent extends HomeEvent {}

class GetOneProductEvent extends HomeEvent {
  int? id;
  GetOneProductEvent({this.id});
}
class GetSearchProductEvent extends HomeEvent {
  bool? sort;
  String? limit;
  String? category;
  GetSearchProductEvent({this.sort, this.category, this.limit});
}

class DeleteOneProductEvent extends HomeEvent {
  int? id;
  DeleteOneProductEvent({this.id});
}

class AddProductToCardEvent extends HomeEvent {
  int? id;
  AddProductToCardEvent({this.id});
}

class AddProductToCartEvent extends HomeEvent {
  final ProductData data;

  AddProductToCartEvent({required this.data});

  @override
  List<Object> get props => [data];
}