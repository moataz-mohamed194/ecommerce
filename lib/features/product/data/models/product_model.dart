import '../../domain/entities/product.dart';

class ProductDataModel extends ProductData {
  ProductDataModel(
      {int? id,
      String? price,
      String? title,
      String? description,
        dynamic? idProduct,
        dynamic count,
      String? category,
      String? image,
      RatingDataModel? rating})
      : super(
            id: id,
            title: title,
            price: price,
      count:count,
            description: description,
            image: image,
      idProduct:idProduct,
            category: category,
            rating: rating);
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      count: json['count'] ?? '',
        idProduct: json['idProduct'] ?? '',
      price: json['price'].toString() ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      rating: json['rating'] != null
          ? RatingDataModel.fromJson(json['rating'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'count': count,
      'description': description,
      'idProduct': idProduct,
      'category': category,
      'rating': rating,
      'image': image
    };
  }
}

class RatingDataModel extends RatingData {
  RatingDataModel({num? count, num? rate}) : super(count: count, rate: rate);
  factory RatingDataModel.fromJson(Map<String, dynamic> json) {
    return RatingDataModel(
        count: json['count'] ?? '', rate: json['rate'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'rate': rate};
  }
}
