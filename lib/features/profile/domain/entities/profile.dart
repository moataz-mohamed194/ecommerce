import 'package:equatable/equatable.dart';

class ProfileData extends Equatable {
  int? id;
  String? email;
  String? password;
  String? phone;
  String? username;
  NameData? names;
  AddressData? address;
  ProfileData(
      {this.email,
      this.password,
        this.names,
        this.address,
        this.username,
      this.phone,
      this.id,});

  @override
  List<Object?> get props =>
      [email, password, id, phone,names, address,username];
}

class NameData extends Equatable {
  String? firstName;
  String? lastName;
  NameData({this.firstName, this.lastName});

  @override
  List<Object?> get props => [firstName, lastName];
}

class AddressData extends Equatable {
  String? city;
  String? street;
  String? number;
  String? zipcode;
  GeolocationData? geolocation;
  AddressData({this.geolocation, this.zipcode, this.city, this.street, this.number});

  @override
  List<Object?> get props => [geolocation, zipcode, city, street, number];
}

class GeolocationData extends Equatable{
  String? lat;
  String? long;
  GeolocationData({this.lat, this.long});

  @override
  List<Object?> get props => [lat, long];

}