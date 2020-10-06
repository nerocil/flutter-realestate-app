import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/profile/models/model_profile.dart';
import 'package:get/get.dart';
class MyDalali extends StatelessWidget {
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
              "Registered Dalali",
              style: Get.textTheme.headline6.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "List of registered dalali ...",
              style: Get.textTheme.caption.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Dalali.dalali.length,
              itemBuilder: (context, index) {
                final dalali = Dalali.dalali[index];
                return Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image(
                            image: AssetImage(dalali.userImage),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: 10),
                      Container(
                        width:80,
                        child: Text( dalali.name,
                          style: Get.textTheme.bodyText1.copyWith(
                            fontFamily: ("medium"),
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Divider()
        ],
      ),
    );
  }
}
