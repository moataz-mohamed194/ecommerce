import '../../domain/entities/profile.dart';

class ProfileDataModel extends ProfileData {
  ProfileDataModel(
      {int? id,
      String? email,
        String? username,
      String? password,
      String? phone,
        AddressDataModel? address,
        NameDataModel? names})
      : super(
            id: id,
      names: names,
      phone: phone,
      username:username,
      address:address,
      password: password,
      email: email);
  factory ProfileDataModel.fromJson(Map<String, dynamic> json) {
    return ProfileDataModel(
      id: json['id'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'].toString() ?? '',
      email: json['email'] ?? '',
        username:json['username']??'',
      names: json['name'] != null
          ? NameDataModel.fromJson(json['name'])
          : null,
      address: json['address'] != null
          ? AddressDataModel.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'names': names,
      'phone': phone,
      'address': address,
      'password': password,
      'username': username,
      'email': email
    };
  }
}

class NameDataModel extends NameData {
  NameDataModel({String? firstName, String? lastName}) : super(firstName: firstName, lastName: lastName);
  factory NameDataModel.fromJson(Map<String, dynamic> json) {
    return NameDataModel(
        firstName: json['firstname'] ?? '', lastName: json['lastname'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'firstname': firstName, 'lastname': lastName};
  }
}

class GeolocationDataModel extends GeolocationData {
  GeolocationDataModel({String? lat, String? long}) : super(lat: lat, long: long);
  factory GeolocationDataModel.fromJson(Map<String, dynamic> json) {
    return GeolocationDataModel(
        lat: json['lat'] ?? '', long: json['long'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }
}

class AddressDataModel extends AddressData {
  AddressDataModel({String? city, String? street, String? number, String? zipcode, GeolocationData? geolocation}) : super(geolocation:geolocation,city: city, street: street, number:number, zipcode:zipcode);
  factory AddressDataModel.fromJson(Map<String, dynamic> json) {
    return AddressDataModel(
        city: json['city'].toString() ?? '', street: json['street'].toString() ?? '', number:json['number'].toString()??'', zipcode:json['zipcode'].toString()??'',
      geolocation: json['geolocation'] != null
          ? GeolocationDataModel.fromJson(json['geolocation'])
          : null,);
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'street': street, 'number':number,'zipcode':zipcode, 'geolocation':geolocation};
  }
}
