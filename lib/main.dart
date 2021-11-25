import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:schedule_manipulation/model/bootcamp_data.dart';
import 'package:schedule_manipulation/ui/curriculum_day_map.dart';

import 'constants.dart';
import 'ui/day_column.dart';
import 'ui/day_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curriculum Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentDayDisplayed = 0;
  int currentDayDisplayedOrig = 0;
  Map? data;
  Map? dataOrig;
  Map? dataFromJson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  // Map? applyChanges(Map? data) {
  //   if (data == null) return null;

  //   //cut from day 96
  //   List days = data['days'];
  //   days = days.sublist(0, 98);

  //   print(days[0]['dateTypes'][dayItems[0]]);

  //   //delete all Algorithms open practice

  //   for (int i = 0; i < days.length; i++) {
  //     var day = days[i];

  //     dayItems.forEach((topic) {
  //       List? items;
  //       items = day['dateTypes'][topic]['preClass']['items'];
  //       items?.forEach((item) {
  //         if (item.toString().contains('Open Practice')) {
  //           day['dateTypes'][topic]['preClass']['items']
  //               [items!.indexOf(item)] = {};
  //         }
  //       });

  //       items = day['dateTypes'][topic]['inClass']['items'];
  //       items?.forEach((item) {
  //         if (item.toString().contains('Open Practice')) {
  //           day['dateTypes'][topic]['inClass']['items']
  //               [items!.indexOf(item)] = {};
  //         }
  //       });

  //       items = day['dateTypes'][topic]['postClass']['items'];
  //       items?.forEach((item) {
  //         if (item.toString().contains('Open Practice')) {
  //           // items!.remove(item);
  //           day['dateTypes'][topic]['postClass']['items']
  //               [items!.indexOf(item)] = {};
  //         }
  //       });
  //     });
  //   }

  //   data['days'] = days;
  //   return data;
  // }

  void getData() async {
    try {
      var tempData = await generateBlankBootcampData();
      var temp2 =
          await getBootcampDataFromJson('data/bootcamp-course-days.json');
      // await getBootcampDataFromJson('data/bootcamp-core-96-days.json');

      setState(() {
        data = tempData;
        dataOrig = temp2;
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
                  Text('Original FTBC/PTBC Schedule'),
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
