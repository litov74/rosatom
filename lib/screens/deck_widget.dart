import 'package:flutter/material.dart';

class StackCard extends StatelessWidget {
  final Widget child;

  StackCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: child == null ? Container() : child,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 5,
        shadowColor: const Color.fromRGBO(4, 163, 213, 0.22),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}
