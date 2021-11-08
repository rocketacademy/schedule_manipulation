import 'package:flutter/material.dart';

import '../constants.dart';

class DayColumn extends StatelessWidget {
  final Map dayData;
  final void Function()? onTap;
  final bool highlight;

  DayColumn(this.dayData, {this.onTap, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: highlight ? 4 : 1, vertical: 2),
          color: highlight ? Colors.black : Colors.transparent,
          child: Column(
            children: [
              MyBox(Colors.white,
                  child:
                      FittedBox(child: Text(dayData['courseDay'].toString()))),
              ...List.generate(
                classColors.length,
                (index) => ClassBox(
                    dayData['dateTypes'][classColors.keys.toList()[index]],
                    classColors.values.toList()[index]),
              ),
              // MyBox(Colors.white,
              //     child:
              //         FittedBox(child: Text(dayData['courseDay'].toString()))),
            ],
          ),
        ),
        onTap: onTap ?? null);
  }
}

class ClassBox extends StatelessWidget {
  final Map lesson;
  final Color color;
  ClassBox(this.lesson, this.color);

  @override
  Widget build(BuildContext context) {
    Color displayColor;
    if ((lesson['inClass'].toString().contains("Open Practice")) ||
        (lesson['postClass'].toString().contains("Open Practice")) ||
        (lesson['postClass'].toString().contains("Implementation")))
      displayColor = color.withGreen(80); //color.withOpacity(0.5);

    else
      displayColor = color;
    return isEmpty(lesson) ? MyBox(Colors.white) : MyBox(displayColor);
  }
}

class MyBox extends StatelessWidget {
  final Color color;
  final Widget? child;
  MyBox(this.color, {this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5),
      height: boxDimension,
      width: boxDimension,
      decoration: BoxDecoration(
        // border: Border.all(),
        color: color,
      ),
      child: Center(child: child),
    );
  }
}
