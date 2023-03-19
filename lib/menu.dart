import 'package:flutter/material.dart';
import 'package:open_gmat_database/constants.dart';

final List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.join_inner),
    label: CategoryNames.ds.value,
    selectedIcon: Icon(Icons.join_full),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.calculate_outlined),
    label: CategoryNames.ps.value,
    selectedIcon: Icon(Icons.calculate),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.lightbulb_outline),
    label: CategoryNames.cr.value,
    selectedIcon: Icon(Icons.lightbulb),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.strikethrough_s_rounded),
    label: CategoryNames.sc.value,
    selectedIcon: Icon(Icons.strikethrough_s),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.book_outlined),
    label: CategoryNames.rc.value,
    selectedIcon: Icon(Icons.book),
  )
];
