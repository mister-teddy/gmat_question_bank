import 'package:flutter/material.dart';

const String GMAT_DATABASE_ENDPOINT =
    "https://teddyfullstack.github.io/gmat-database";

const double narrowScreenWidthThreshold = 450;
const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1500;
const double transitionLength = 500;

enum ColorSeed {
  baseColor('Default', Colors.white),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.deepOrange),
  deepOrange('Red', Colors.red),
  pink('Pink', Colors.pink),
  red('Purple', Color(0xff6750a4));

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

enum ScreenSelected {
  ds(0),
  ps(1),
  cr(2),
  sc(3),
  rc(4);

  const ScreenSelected(this.value);
  final int value;
}

enum CategoryNames {
  ds('Data Sufficiency'),
  ps('Problem Solving'),
  cr('Critical Reasoning'),
  sc('Sentence Correction'),
  rc('Reading Comprehension');

  const CategoryNames(this.value);
  final String value;
}
