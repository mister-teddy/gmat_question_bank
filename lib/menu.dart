import 'package:flutter/material.dart';
import 'package:open_gmat_database/constants.dart';

final List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.widgets_outlined),
    label: CategoryNames.ds.value,
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.format_paint_outlined),
    label: CategoryNames.ps.value,
    selectedIcon: Icon(Icons.format_paint),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.text_snippet_outlined),
    label: CategoryNames.cr.value,
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.invert_colors_on_outlined),
    label: CategoryNames.sc.value,
    selectedIcon: Icon(Icons.opacity),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.question_mark_outlined),
    label: CategoryNames.rc.value,
    selectedIcon: Icon(Icons.question_mark_rounded),
  )
];
