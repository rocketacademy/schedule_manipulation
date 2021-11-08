import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:schedule_manipulation/bootcamp_data.dart';

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

const double boxDimension = 12;

final classColors = {
  'general': Colors.blue,
  'css': Colors.green,
  'algos': Colors.amber,
  'ip': Colors.red,
  'ux': Colors.orange,
  'projects': Colors.deepPurple.shade200,
};

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

bool isEmpty(Map lesson) {
  if ((lesson['preClass']!.isEmpty) &&
      (lesson['inClass']!.isEmpty) &&
      (lesson['postClass']!.isEmpty)) return true;
  return false;
}

class DayDetail extends StatelessWidget {
  final Map dayData;
  const DayDetail(this.dayData);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Container(
        width: max(500, MediaQuery.of(context).size.width / 2),
        child: Center(
          child: Column(
            children: [
              ListTile(
                leading: Text(
                  'Course Day',
                ),
                title: Text(dayData['courseDay'].toString()),
              ),
              ListTile(
                leading: Text('Module'),
                title: Text(dayData['dateTypes']['module']),
              ),
              ClassListTile('General', dayData['dateTypes']['general'],
                  classColors['general']!),
              ClassListTile(
                  'CSS', dayData['dateTypes']['css'], classColors['css']!),
              ClassListTile('algos', dayData['dateTypes']['algos'],
                  classColors['algos']!),
              ClassListTile(
                  'ux', dayData['dateTypes']['ux'], classColors['ux']!),
              ClassListTile(
                  'ip', dayData['dateTypes']['ip'], classColors['ip']!),
              ClassListTile('projects', dayData['dateTypes']['projects'],
                  classColors['projects']!),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassListTile extends StatelessWidget {
  ClassListTile(this.title, this.classData, this.color);
  final String title;
  final Map classData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: color,
        leading: Text(
          title,
        ),
        title:
            isEmpty(classData) ? Text('none') : ClassItemsListing(classData));
  }
}

class ClassItemsListing extends StatelessWidget {
  final Map classData;
  const ClassItemsListing(this.classData);

  Widget generateItems(List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((e) => Text('    ${e['name']}')).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (classData["preClass"].isNotEmpty) ...[
            Text('Pre Class:'),
            generateItems(classData["preClass"]['items']),
            Divider(),
          ],
          if (classData["inClass"].isNotEmpty) ...[
            Text('In Class:'),
            generateItems(classData["inClass"]['items']),
            Divider(),
          ],
          if (classData["postClass"].isNotEmpty) ...[
            Text('Post Class:'),
            generateItems(classData["postClass"]['items']),
            Divider(),
          ],
        ],
      ),
    );
  }
}

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
