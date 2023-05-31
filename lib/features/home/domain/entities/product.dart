import 'package:equatable/equatable.dart';

class ProductData extends Equatable {
  int? id;
  String? title;
  num? price;
  String? description;
  String? category;
  String? image;
  RatingData? rating;

  ProductData(
      {this.description,
      this.price,
      this.category,
      this.id,
      this.title,
      this.image,
      this.rating});

  @override
  List<Object?> get props =>
      [image, price, title, id, rating, category, description];
}

class RatingData extends Equatable {
  num? rate;
  num? count;
  RatingData({this.rate, this.count});

  @override
  // TODO: implement props
  List<Object?> get props => [rate, count];
}
