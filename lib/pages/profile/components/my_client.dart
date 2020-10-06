import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/profile/models/model_profile.dart';
import 'package:get/get.dart';
class MyClient extends StatelessWidget {
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
              "My Clients",
              style: Get.textTheme.headline6.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "List of clients how rent ...",
              style: Get.textTheme.caption.copyWith(
                fontFamily: ("medium"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 118,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Client.clients.length,
              itemBuilder: (context, index) {
                final client = Client.clients[index];
                return Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image(
                            image: AssetImage(client.userImage),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(height: 10),
                      Text( client.realEstateType.name,
                        style: Get.textTheme.caption.copyWith(
                          fontFamily: ("medium"),
                        ),
                      ),
                      Container(
                        width:80,
                        child: Text( client.name,
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
          SizedBox(height: 17),
          Divider()
        ],
      ),
    );
  }
}
