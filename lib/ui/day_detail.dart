import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';

class DayDetail extends StatelessWidget {
  final Map dayData;
  const DayDetail(this.dayData);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
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
    return isEmpty(classData)
        ? Container()
        : ListTile(
            tileColor: color,
            leading: Text(
              title,
            ),
            title: isEmpty(classData)
                ? Text('none')
                : ClassItemsListing(classData));
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
