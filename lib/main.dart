import 'package:flutter/material.dart';
import 'ui/module_view.dart';
import 'ui/whole_schedule_view.dart';

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
      home: ModuleView(),
    );
  }
}
