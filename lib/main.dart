import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:schedule_manipulation/bootcamp_data.dart';

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

const dayItems = ['general', 'css', 'algos', 'ux', 'ip', 'projects'];

class _MyHomePageState extends State<MyHomePage> {
  int currentDayDisplayed = 0;
  Map? data;
  Map? dataFromJson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  Map? applyChanges(Map? data) {
    if (data == null) return null;

    //cut from day 96
    List days = data['days'];
    days = days.sublist(0, 98);

    print(days[0]['dateTypes'][dayItems[0]]);

    //delete all Algorithms open practice
    List tempDays = [];
    for (int i = 0; i < days.length; i++) {
      var day = days[i];

      dayItems.forEach((topic) {
        List? items;
        items = day['dateTypes'][topic]['preClass']['items'];
        items?.forEach((item) {
          if (item.toString().contains('Open Practice')) {
            day['dateTypes'][topic]['preClass']['items']
                [items!.indexOf(item)] = {};
          }
        });

        items = day['dateTypes'][topic]['inClass']['items'];
        items?.forEach((item) {
          if (item.toString().contains('Open Practice')) {
            day['dateTypes'][topic]['inClass']['items']
                [items!.indexOf(item)] = {};
          }
        });

        items = day['dateTypes'][topic]['postClass']['items'];
        items?.forEach((item) {
          if (item.toString().contains('Open Practice')) {
            // items!.remove(item);
            day['dateTypes'][topic]['postClass']['items']
                [items!.indexOf(item)] = {};
          }
        });
      });
    }

    data['days'] = days;
    return data;
  }

  void getData() async {
    try {
      var jdata = await DefaultAssetBundle.of(context)
          // .loadString('data/bootcamp-course-days.json');
          .loadString('data/bootcamp-core-96-days.json');

      setState(() {
        data = jsonDecode(jdata);
        // data = applyChanges(data);
      });

      // data = bootcampData;
    } catch (e, s) {
      print('$e : $s');
    }

    // print(data?.keys);
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
        child: data == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: boxDimension * 9,
                    color: Colors.grey,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                            data?["days"].length,
                            (index) => DayColumn(
                                  data?["days"][index],
                                  onTap: () {
                                    // print(data?['days'][index]['dateTypes'].keys);
                                    setState(() {
                                      currentDayDisplayed = index;
                                    });
                                  },
                                  highlight: currentDayDisplayed == index,
                                ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: DayDetail(data?["days"][currentDayDisplayed])),
                  ),
                ],
              ),
      ),
    );
  }
}
