import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  final Color color;
  final Function()? onTap;
  final Widget child;

  RoundedBox({required this.color, this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: child,
      ),
    );
  }
}
