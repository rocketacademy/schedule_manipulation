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

class ModuleDayMap extends StatefulWidget {
  final void Function(int)? activeDayCallback;
  final Map data;
  final bool uniformSize;

  ModuleDayMap(this.data, {this.activeDayCallback, this.uniformSize = false});

  @override
  _ModuleDayMapState createState() => _ModuleDayMapState();
}

class _ModuleDayMapState extends State<ModuleDayMap> {
  int currentDayDisplayed = 0;

  @override
  Widget build(BuildContext context) {
    List daysSource = widget.data['days'];
    // List moduleSizes = List.generate(6, (index) => 16);
    List moduleSizes = (widget.uniformSize)
        ? [1, 16, 16, 16, 16, 16, 16] //List.generate(6, (index) => 16)
        : [1, 18, 24, 19, 16, 12, 7];

    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(moduleSizes.length, (moduleIndex) {
          return Container(
            height: boxDimension * 9,
            width: boxDimension * 30,
            color: Colors.grey,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  moduleSizes[moduleIndex],
                  (dayIndex) {
                    var moduleSize = moduleSizes[moduleIndex];

                    var daySourceIndex = 0;
                    moduleSizes.sublist(0, moduleIndex).forEach((s) {
                      var size = s as int;
                      daySourceIndex += size;
                    });

                    print(daySourceIndex);
                    if (daySourceIndex >= daysSource.length) daySourceIndex = 0;

                    return DayColumn(
                      daysSource[daySourceIndex + dayIndex],
                      onTap: () {
                        setState(() {
                          currentDayDisplayed = daySourceIndex + dayIndex;
                        });
                        if (widget.activeDayCallback != null)
                          widget.activeDayCallback!(daySourceIndex + dayIndex);
                      },
                      highlight:
                          currentDayDisplayed == daySourceIndex + dayIndex,
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
