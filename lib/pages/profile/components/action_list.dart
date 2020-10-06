import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionList extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final bool proFeature;
  final VoidCallback onTap;

  const ActionList(
      {Key key,
      @required this.iconData,
      @required this.title,
      @required this.subTitle,
      @required this.proFeature,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey[700],
              ),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Get.textTheme.headline6,
                    ),
                    SizedBox(width: 10),
                    proFeature
                        ? Container(
                            padding: EdgeInsets.only(left: 5, right: 5, bottom: 2),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.blueGrey),
                            child: Text(
                              "pro",
                              style: Get.textTheme.caption.copyWith(color: Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Text(
                  subTitle,
                  style: Get.textTheme.caption,
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
