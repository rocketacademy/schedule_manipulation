import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Curriculum Visualizer'),
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentDayDisplayed = 0;
  Map? data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  void getData() async {
    try {
      var jdata = await DefaultAssetBundle.of(context)
          .loadString('data/bootcamp-course-days.json');
      setState(() {
        data = jsonDecode(jdata);
      });
    } catch (e, s) {
      print('$e : $s');
    }

    print(data?.keys);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
    return Container(
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
            ClassListTile(
                'algos', dayData['dateTypes']['algos'], classColors['algos']!),
            ClassListTile('ux', dayData['dateTypes']['ux'], classColors['ux']!),
            ClassListTile('ip', dayData['dateTypes']['ip'], classColors['ip']!),
            ClassListTile('projects', dayData['dateTypes']['projects'],
                classColors['projects']!),
          ],
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
      title: isEmpty(classData) ? Text('none') : Text(classData.toString()),
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
                      classColors.values.toList()[index])),
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
    return isEmpty(lesson) ? MyBox(Colors.white) : MyBox(color);
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
