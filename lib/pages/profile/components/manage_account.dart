import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/home/models/home_model.dart';
import 'package:get/get.dart';
class MyProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "My Properties",
              style: Get.textTheme.headline6.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "List of propeties you own",
              style: Get.textTheme.caption.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 161,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Property.properties.length,
              itemBuilder: (context, index) {
                final property = Property.properties[index];
                return Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(property.propertyImage),
                            width: 140,
                            height: 100,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: 10),
                      Text( property.realEstateType.name,
                        style: Get.textTheme.caption.copyWith(
                          fontFamily: ("medium"),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width:140,
                        child: Text( "This is placeholder for property detail from owner",
                          style: Get.textTheme.bodyText1.copyWith(
                            fontFamily: ("medium"),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 17),
          Divider()
        ],
      ),
    );
  }
}
