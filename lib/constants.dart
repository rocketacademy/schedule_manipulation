import 'package:flutter/material.dart';

bool isEmpty(Map lesson) {
  if ((lesson['preClass']!.isEmpty) &&
      (lesson['inClass']!.isEmpty) &&
      (lesson['postClass']!.isEmpty)) return true;
  return false;
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
