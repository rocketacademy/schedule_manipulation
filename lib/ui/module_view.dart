import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schedule_manipulation/model/bootcamp_data.dart';

import 'curriculum_day_map.dart';
import 'day_detail.dart';

class ModuleView extends StatefulWidget {
  const ModuleView({Key? key}) : super(key: key);

  @override
  _ModuleViewState createState() => _ModuleViewState();
}

class _ModuleViewState extends State<ModuleView> {
  Map? dataPTBC;
  int currentDayDisplayed = 0;

  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void getData() async {
    try {
      var tempData =
          await getBootcampDataFromJson('data/ptbc-course-days.json');
      // await getBootcampDataFromJson('data/bootcamp-core-96-days.json');

      setState(() {
        dataPTBC = tempData;
      });
    } catch (e, s) {
      print('$e : $s');
    }

    // print(data?.keys);
  }

  void setActiveDayPTBC(int index) {
    setState(() {
      currentDayDisplayed = index;
    });
  }

  List<Widget> buildModules() {
    List<Widget> l = [];

    l.add(Text('Live PTBC Schedule'));
    l.add(CurriculumDayMap(dataPTBC!, activeDayCallback: setActiveDayPTBC));

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Curriculum Visualizer'),
      ),
      body: Center(
        child: dataPTBC == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Live PTBC Schedule'),
                  CurriculumDayMap(dataPTBC!,
                      activeDayCallback: setActiveDayPTBC),
                  ...buildModules()
                  //newCurriculumDayMap(),
                  // Expanded(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: [

                  //       SingleChildScrollView(
                  //           controller: ScrollController(),
                  //           child: Column(
                  //             children: [
                  //               Text('Live PTBC Schedule'),
                  //               DayDetail(
                  //                   dataPTBC?["days"][currentDayDisplayedPTBC]),
                  //             ],
                  //           )),

                  //     ],
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}
