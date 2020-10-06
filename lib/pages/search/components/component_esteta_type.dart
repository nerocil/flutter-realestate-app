import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/search/models/search_models.dart';
import 'package:flutter_svg/svg.dart';
class ComponentEstateType extends StatefulWidget {
  final Function(int index) onSelect;

  const ComponentEstateType({Key key, @required this.onSelect}) : super(key: key);
  @override
  _ComponentEstateTypeState createState() => _ComponentEstateTypeState();
}

class _ComponentEstateTypeState extends State<ComponentEstateType> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: RealEstateType.realEstateType.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              onTap: (){
                widget.onSelect(index);
                setState(() {
                  _selectedIndex = index;

                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                child: Column(
                  children: [
                    Container(
                      padding:EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: index == _selectedIndex ? Colors.green[700] : Colors.grey[100],
                      ),
                      child: SvgPicture.asset(
                        RealEstateType.realEstateType[index].svgFileName,
                        height: 26,
                        width: 26,
                        color: index == _selectedIndex ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      RealEstateType.realEstateType[index].name,
                      style: TextStyle(
                        color: index == _selectedIndex ? Colors.green[700] : Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'regular',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
