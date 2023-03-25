// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ComponentGroupDecoration extends StatelessWidget {
  const ComponentGroupDecoration(
      {super.key, this.label, required this.children});

  final String? label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // Fully traverse this component group before moving on
    return FocusTraversalGroup(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                if (label != null)
                  Text(label!, style: Theme.of(context).textTheme.titleLarge),
                ...children
              ],
            ),
          ),
        ),
      ),
    );
  }
}
