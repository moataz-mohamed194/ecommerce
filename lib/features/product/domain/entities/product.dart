import 'package:equatable/equatable.dart';

class ProductData extends Equatable {
  int? id;
  String? title;
  String? price;
  dynamic? idProduct;
  dynamic? count;
  String? description;
  String? category;
  String? image;
  RatingData? rating;

  ProductData(
      {this.description,
      this.price,
      this.category,
      this.id,
        this.count,
        this.idProduct,
      this.title,
      this.image,
      this.rating});

  @override
  List<Object?> get props =>
      [image, price, title,count, id,idProduct, rating, category, description];
}

class RatingData extends Equatable {
  num? rate;
  num? count;
  RatingData({this.rate, this.count});

  @override
  List<Object?> get props => [rate, count];
}
