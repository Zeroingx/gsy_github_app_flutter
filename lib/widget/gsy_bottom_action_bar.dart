import 'package:flutter/material.dart';

class GSYBottomAppBar extends StatelessWidget {
  const GSYBottomAppBar({super.key, 
    this.color,
    this.fabLocation,
    this.shape,
    this.rowContents,
  });

  final Color? color;
  final FloatingActionButtonLocation? fabLocation;
  final NotchedShape? shape;
  final List<Widget>? rowContents;

  static final List<FloatingActionButtonLocation> kCenterLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: color,
      shape: shape,
      child: Row(children: rowContents!),
    );
  }
}
