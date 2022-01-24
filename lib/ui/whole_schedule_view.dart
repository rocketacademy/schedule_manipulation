import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:schedule_manipulation/model/bootcamp_data.dart';

import 'curriculum_day_map.dart';
import 'day_detail.dart';

class WholeScheduleView extends StatefulWidget {
  @override
  _WholeScheduleViewState createState() => _WholeScheduleViewState();
}

class _WholeScheduleViewState extends State<WholeScheduleView> {
  int currentDayDisplayed = 0;
  int currentDayDisplayedOrig = 0;
  int currentDayDisplayedPTBC = 0;
  Map? data;
  Map? dataOrig;
  Map? dataPTBC;
  Map? dataFromJson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void getData() async {
    try {
      var tempData = await generateBlankBootcampData();
      var temp2 =
          await getBootcampDataFromJson('data/bootcamp-course-days.json');
      var temp3 = await getBootcampDataFromJson('data/ptbc-course-days.json');
      // await getBootcampDataFromJson('data/bootcamp-core-96-days.json');

      setState(() {
        data = tempData;
        dataOrig = temp2;
        dataPTBC = temp3;
        // data = applyChanges(data);
      });

      // data = bootcampData;
    } catch (e, s) {
      print('$e : $s');
    }

    // print(data?.keys);
  }

  void setActiveDay(int index) {
    setState(() {
      currentDayDisplayed = index;
    });
    print(data!['days'][index]);
  }

  void setActiveDayOrig(int index) {
    setState(() {
      currentDayDisplayedOrig = index;
    });
  }

  void setActiveDayPTBC(int index) {
    setState(() {
      currentDayDisplayedPTBC = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Curriculum Visualizer'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(children: [
                    SingleChildScrollView(
                      child: SelectableText(
                        JsonEncoder.withIndent('    ').convert(data),
                      ),
                    ),
                  ]),
                );
              },
              icon: Icon(Icons.download_sharp))
        ],
      ),
      body: Center(
        child: data == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Proposed PTBC Schedule'),
                  CurriculumDayMap(data!, activeDayCallback: setActiveDay),
                  Text('Live PTBC Schedule'),
                  CurriculumDayMap(dataPTBC!,
                      activeDayCallback: setActiveDayPTBC),
                  Text('Live FTBC Schedule'),
                  CurriculumDayMap(dataOrig!,
                      activeDayCallback: setActiveDayOrig),
                  //newCurriculumDayMap(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                Text('Proposed PTBC Schedule'),
                                DayDetail(data?["days"][currentDayDisplayed]),
                              ],
                            )),
                        SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                Text('Live PTBC Schedule'),
                                DayDetail(
                                    dataPTBC?["days"][currentDayDisplayedPTBC]),
                              ],
                            )),
                        SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                Text('Original FTBC/PTBC Schedule'),
                                DayDetail(
                                    dataOrig?["days"][currentDayDisplayedOrig]),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
