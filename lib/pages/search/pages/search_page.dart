import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/common/app_button.dart';
import 'package:flutter_real_estate/common/app_helper.dart';
import 'package:flutter_real_estate/pages/search/components/component_bathroom.dart';
import 'package:flutter_real_estate/pages/search/components/component_bedroom.dart';
import 'package:flutter_real_estate/pages/search/components/component_esteta_type.dart';
import 'package:flutter_real_estate/pages/search/components/component_near_by.dart';
import 'package:flutter_real_estate/pages/search/components/component_rental_frequency.dart';
import 'package:flutter_real_estate/pages/search/models/search_models.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int segmentedControlValue = 0;
  RangeValues _currentRangeValues = const RangeValues(200, 700);

  double min;
  double max;

  @override
  void initState() {
    super.initState();
    min = _currentRangeValues.start * 1000;
    max = _currentRangeValues.end * 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 5),
              child: AppButton(
                onTap: () {},
                text: "RESET",
                textColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  child: CupertinoSegmentedControl<int>(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    selectedColor: Colors.green[700],
                    borderColor: Colors.green[700],
                    children: {
                      0: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'RESIDENTIAL',
                        ),
                      ),
                      1: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'COMMERCIAL',
                        ),
                      ),
                    },
                    onValueChanged: (int val) {
                      setState(() {
                        segmentedControlValue = val;
                      });
                    },
                    groupValue: segmentedControlValue,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.5),
                child: CupertinoTextField(
                  keyboardType: TextInputType.text,
                  placeholder: "Enter region name",
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onTap: () {},
                  clearButtonMode: OverlayVisibilityMode.editing,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {},
                  placeholderStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontFamily: 'regular',
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'regular',
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(9.0, 8.0, 9.0, 8.0),
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.green[700],
                      size: 17,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.green[700]),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Property type",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ComponentEstateType(
                onSelect: (index) {
                  print(index);
                },
              ),
              Divider(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Rental frequency",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              SizedBox(height: 15),
              ComponentRentalFrequency(onSelect: (index) {
                print(index);
              }),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rental Price",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${AppHelper.priceFormat(price: min)} - ${AppHelper.priceFormat(price: max)}tsh",
                      style: TextStyle(fontSize: 14, color: Colors.green[700], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 1000,
                divisions: 20,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString() + "K",
                  _currentRangeValues.end.round().toString() + "K",
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                    min = _currentRangeValues.start * 1000;
                    max = _currentRangeValues.end * 1000;
                  });
                },
              ),
              Divider(),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Near by",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ComponentNearBy(onSelect: (index) {
                print(index);
              }),

              SizedBox(height: 15),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Bedrooms",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ComponentBedroom(onSelect: (index) {
                print(index);
              }),
              SizedBox(height: 15),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Bathrooms",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ComponentBathroom(onSelect: (index) {
                print(index);
              }),
              SizedBox(height: 30),
              ButtonTheme(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minWidth: 220,
                height: 45,
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.green[700],
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Show Properties",
                          style: Get.textTheme.bodyText1
                              .copyWith(fontFamily: "Medium", color: Colors.white, letterSpacing: .5)),
                      SizedBox(width: 10),
                      Icon(Icons.keyboard_arrow_right, color: Colors.white,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
