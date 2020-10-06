import 'package:flutter_real_estate/pages/search/models/search_models.dart';

class Client{
  String name;
  String userImage;
  RealEstateType realEstateType;

  Client(this.name, this.userImage, this.realEstateType);

  static List<Client> get clients{
    return [
      Client("James Sanja", "assets/images/300_14.jpg", RealEstateType.realEstateType[0]),
      Client("Agnese Shayo", "assets/images/300_17.jpg", RealEstateType.realEstateType[1]),
      Client("Asha Abdala", "assets/images/300_18.jpg", RealEstateType.realEstateType[2]),
      Client("Sia Lema", "assets/images/300_19.jpg", RealEstateType.realEstateType[3]),
      Client("Fred Amon", "assets/images/300_21.jpg", RealEstateType.realEstateType[1]),
      Client("Franco Mwakalinga", "assets/images/300_24.jpg", RealEstateType.realEstateType[4]),
    ];
  }

}

class Dalali{
  String name;
  String userImage;
  RealEstateType realEstateType;

  Dalali(this.name, this.userImage, this.realEstateType);

  static List<Dalali> get dalali{
    return [
      Dalali("Tedy Kayu", "assets/images/300_19.jpg", RealEstateType.realEstateType[3]),
      Dalali("Fred Amon", "assets/images/300_21.jpg", RealEstateType.realEstateType[5]),
      Dalali("Franco Kwagu", "assets/images/300_24.jpg", RealEstateType.realEstateType[6]),
      Dalali("James Sanja", "assets/images/300_14.jpg", RealEstateType.realEstateType[1]),
      Dalali("Agnese Shayo", "assets/images/300_17.jpg", RealEstateType.realEstateType[3]),
      Dalali("Asha Abdala", "assets/images/300_18.jpg", RealEstateType.realEstateType[2]),

    ];
  }

}