import 'package:flutter/material.dart';
import 'package:flutter_real_estate/common/app_helper.dart';
import 'package:flutter_real_estate/pages/home/models/home_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
class ComponentCard extends StatelessWidget {
  final Property property;

  const ComponentCard({Key key, @required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300].withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ) // changes position of shadow)
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(property.propertyImage),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      property.realEstateType.svgFileName,
                      width: 14,
                      height: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${property.realEstateType.name}",
                      style: Get.textTheme.caption,
                    ),
                    SizedBox(width: 15),
                    Icon(
                      Icons.pin_drop,
                      size: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${property.location}",
                      style: Get.textTheme.caption,
                    ),
                    SizedBox(width: 15),
                    SvgPicture.asset(
                      property.nearBy.svgFileName,
                      width: 14,
                      height: 14,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Near by ${property.nearBy.name}",
                      style: Get.textTheme.caption,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "This is placeholder for description detail provider by owner or Dalali",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(  text: TextSpan(
                      text: "${AppHelper.priceFormat(price: property.price)}",
                      style: TextStyle(
                        color: Colors.green[700],
                        fontFamily: "medium",
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'tsh / ', style: new TextStyle(fontSize: 13)),
                        TextSpan(text: property.rentalFrequency.frequency, style: new TextStyle(fontSize: 10,fontFamily: "regular", color: Colors.black)),
                      ],
                    ) ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/svg/bedroom.svg", width: 18,height: 18,),
                        Text(property.bedroom.toString()),
                        SizedBox(width: 18),
                        SvgPicture.asset("assets/images/svg/bathroom.svg", width: 18,height: 18,),
                        Text(property.bathroom.toString()),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
