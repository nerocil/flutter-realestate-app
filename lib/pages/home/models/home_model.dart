import 'package:flutter/foundation.dart';
import 'package:flutter_real_estate/pages/search/models/search_models.dart';

class Property {
  double price;
  int bedroom;
  int bathroom;
  String location;
  NearBy nearBy;
  RentalFrequency rentalFrequency;
  RealEstateType realEstateType;
  String propertyImage;
  bool available;

  Property(
      {@required this.price,
      @required @required this.bedroom,
      @required this.bathroom,
      @required this.location,
      @required this.nearBy,
      @required this.rentalFrequency,
      @required this.realEstateType,
      @required this.propertyImage,
      @required this.available});

  static List<Property> get properties {
    return [
      Property(
          price: 200000,
          bedroom: 3,
          bathroom: 2,
          location: "Dar es Salaam",
          nearBy: NearBy.nearBy[0],
          rentalFrequency: RentalFrequency.rentalFrequency[0],
          realEstateType: RealEstateType.realEstateType[0],
          propertyImage: 'assets/images/houses/house5.jpg',
          available: true),
      Property(
          price: 500000,
          bedroom: 2,
          bathroom: 1,
          location: "Morogoro",
          nearBy: NearBy.nearBy[1],
          rentalFrequency: RentalFrequency.rentalFrequency[1],
          realEstateType: RealEstateType.realEstateType[1],
          propertyImage: 'assets/images/houses/house2.jpg',
          available: true),
      Property(
          price: 35200,
          bedroom: 4,
          bathroom: 2,
          location: "Zanzibar",
          nearBy: NearBy.nearBy[2],
          rentalFrequency: RentalFrequency.rentalFrequency[2],
          realEstateType: RealEstateType.realEstateType[2],
          propertyImage: 'assets/images/houses/house3.jpg',
          available: true),
      Property(
          price: 55000,
          bedroom: 1,
          bathroom: 1,
          location: "Zanzibar",
          nearBy: NearBy.nearBy[3],
          rentalFrequency: RentalFrequency.rentalFrequency[3],
          realEstateType: RealEstateType.realEstateType[3],
          propertyImage: 'assets/images/houses/house4.jpg',
          available: true),
      Property(
          price: 55000,
          bedroom: 1,
          bathroom: 1,
          location: "Zanzibar",
          nearBy: NearBy.nearBy[3],
          rentalFrequency: RentalFrequency.rentalFrequency[3],
          realEstateType: RealEstateType.realEstateType[3],
          propertyImage: 'assets/images/houses/house5.jpg',
          available: true),
      Property(
          price: 55000,
          bedroom: 1,
          bathroom: 1,
          location: "Arusha",
          nearBy: NearBy.nearBy[5],
          rentalFrequency: RentalFrequency.rentalFrequency[2],
          realEstateType: RealEstateType.realEstateType[1],
          propertyImage: 'assets/images/houses/house1.jpeg',
          available: true),
    ];
  }
}
