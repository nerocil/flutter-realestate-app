import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/home/components/compnent_card.dart';
import 'package:flutter_real_estate/pages/home/components/component_estate_type.dart';
import 'package:flutter_real_estate/pages/home/models/home_model.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          floating: true,
          pinned: false,
          centerTitle: true,
          title: Text(
            "Property for rent",
            style: TextStyle(color: Colors.black),
          ),
          expandedHeight: 100.0,
          bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                            Icons.search,
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
                    ComponentEstateType(onSelect: (index) {
                      print(index);
                    })
                  ],
                ),
              ),
              preferredSize: Size(double.infinity, 87)),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final property = Property.properties[index];
              return ComponentCard(
                property: property,
              );
            },
            childCount: Property.properties.length,
          ),
        ),
      ],
    );
  }
}
