import 'package:flutter/material.dart';
import 'package:flutter_real_estate/pages/search/models/search_models.dart';
class ComponentBedroom extends StatefulWidget {
  final Function(int index) onSelect;

  const ComponentBedroom({Key key, @required this.onSelect}) : super(key: key);
  @override
  _ComponentBedroomState createState() => _ComponentBedroomState();
}

class _ComponentBedroomState extends State<ComponentBedroom> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Bedroom.numbers.length,
          itemBuilder: (context, index) {
            String room ;
            int number = Bedroom.numbers[index].number;
            if(number == 0){
              room = 'Any';
            }else if(index+1 == Bedroom.numbers.length ){
              room = "$number+";
            }else{
              room = number.toString();
            }
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index == _selectedIndex ? Colors.green[700] :  Colors.grey[200],
                      ),
                      child: Text(room,
                        style: TextStyle(
                          color: index == _selectedIndex ? Colors.white : Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 17,
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
