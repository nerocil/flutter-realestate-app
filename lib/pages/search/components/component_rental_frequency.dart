import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/search/models/search_models.dart';
class ComponentRentalFrequency extends StatefulWidget {
  final Function(int index) onSelect;

  const ComponentRentalFrequency({Key key, @required this.onSelect}) : super(key: key);
  @override
  _ComponentRentalFrequencyState createState() => _ComponentRentalFrequencyState();
}

class _ComponentRentalFrequencyState extends State<ComponentRentalFrequency> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: RentalFrequency.rentalFrequency.length,
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
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index == _selectedIndex ? Colors.green[700] :  Colors.grey[100],
                      ),
                      child: Text(
                        RentalFrequency.rentalFrequency[index].frequency,
                        style: TextStyle(
                          color: index == _selectedIndex ? Colors.white : Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'regular',
                        ),
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
