part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorCartHomeState extends HomeState {
  final String message;

  ErrorCartHomeState({required this.message});

  @override
  List<Object> get props => [message];
}
class ErrorHomeState0 extends HomeState {
  final String message;

  ErrorHomeState0({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedHomeState extends HomeState {
  final List<ProductData> data;
  final List dataCategory;

  LoadedHomeState({required this.data, required this.dataCategory});

  @override
  List<Object> get props => [data, dataCategory];
}

class LoadedHomeSearchState extends HomeState {
  final List<ProductData> data;
  final List dataCategory;

  LoadedHomeSearchState({required this.data, required this.dataCategory});

  @override
  List<Object> get props => [data, dataCategory];
}

class LoadedOneProductHomeState extends HomeState {
  final ProductData data;

  LoadedOneProductHomeState({required this.data});

  @override
  List<Object> get props => [data];
}

class DeleteProductHomeState extends HomeState {
  final bool data;

  DeleteProductHomeState({required this.data});

  @override
  List<Object> get props => [data];
}

class AddedToCartProductAccountState extends HomeState {
  final bool data;

  AddedToCartProductAccountState({required this.data});

  @override
  List<Object> get props => [data];
}
