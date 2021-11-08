import 'package:flutter/material.dart';

import '../constants.dart';
import 'day_column.dart';

class CurriculumDayMap extends StatefulWidget {
  void Function(int)? activeDayCallback;
  Map data;

  CurriculumDayMap(this.data, {this.activeDayCallback});

  @override
  _CurriculumDayMapState createState() => _CurriculumDayMapState();
}

class _CurriculumDayMapState extends State<CurriculumDayMap> {
  int currentDayDisplayed = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxDimension * 9,
      color: Colors.grey,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(
              widget.data["days"].length,
              (index) => DayColumn(
                    widget.data["days"][index],
                    onTap: () {
                      setState(() {
                        currentDayDisplayed = index;
                      });
                      if (widget.activeDayCallback != null)
                        widget.activeDayCallback!(index);
                    },
                    highlight: currentDayDisplayed == index,
                  ))
        ],
      ),
    );
  }
}
