import 'package:flutter/foundation.dart';

class RealEstateType{
  String name;
  String svgFileName;

  RealEstateType({@required this.name, @required this.svgFileName});

  static List<RealEstateType> get realEstateType{
    return [
      RealEstateType(name: "Apartment", svgFileName: "assets/images/svg/apartment.svg"),
      RealEstateType(name: "Townhouse", svgFileName: "assets/images/svg/townhouse.svg"),
      RealEstateType(name: "House + garage", svgFileName: "assets/images/svg/house-with-garage.svg"),
      RealEstateType(name: "Family house", svgFileName: "assets/images/svg/country-family-house.svg"),
      RealEstateType(name: "Small store", svgFileName: "assets/images/svg/little-store.svg"),
      RealEstateType(name: "street-shop", svgFileName: "assets/images/svg/street-shop.svg"),
      RealEstateType(name: "offices", svgFileName: "assets/images/svg/office-building.svg"),
    ];
  }
}

class RentalFrequency{
  String frequency;

  RentalFrequency({@required this.frequency});

  static List<RentalFrequency> get rentalFrequency{
    return [
      RentalFrequency(frequency: "YEARLY"),
      RentalFrequency(frequency: "MONTHLY"),
      RentalFrequency(frequency: "WEEKLY"),
      RentalFrequency(frequency: "DAILY"),
    ];
  }
}

class Bedroom{
  int number;

  Bedroom({@required this.number});

  static List<Bedroom> get numbers{
    return [
      Bedroom(number: 0),
      Bedroom(number: 1),
      Bedroom(number: 2),
      Bedroom(number: 3),
      Bedroom(number: 4),
    ];
  }
}

class Bathroom{
  int number;

  Bathroom({@required this.number});

  static List<Bathroom> get numbers{
    return [
      Bathroom(number: 0),
      Bathroom(number: 1),
      Bathroom(number: 2),
      Bathroom(number: 3),
      Bathroom(number: 4),
    ];
  }
}

class NearBy{
  String name;
  String svgFileName;

  NearBy({@required this.name, @required this.svgFileName});

  static List<NearBy> get nearBy{
    return [
      NearBy(name: "Restaurant", svgFileName: "assets/images/near/restaurant.svg"),
      NearBy(name: "Bust stop", svgFileName: "assets/images/near/bus-stop.svg"),
      NearBy(name: "Beach", svgFileName: "assets/images/near/beach.svg"),
      NearBy(name: "Stadium", svgFileName: "assets/images/near/stadium.svg"),
      NearBy(name: "Airport", svgFileName: "assets/images/near/airport.svg"),
      NearBy(name: "Hospital", svgFileName: "assets/images/near/hospital.svg"),
      NearBy(name: "Repair Shop", svgFileName: "assets/images/near/repair-shop.svg"),
      NearBy(name: "School", svgFileName: "assets/images/near/school.svg"),
      NearBy(name: "University", svgFileName: "assets/images/near/university.svg"),
    ];
  }
}