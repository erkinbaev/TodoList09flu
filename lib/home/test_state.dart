
import 'package:flutter/material.dart';

class TestState {
  final bool isVisible;
  final Color color;
  final double height;
  final double width;

  const TestState({required this.isVisible, required this.color, required this.width, required this.height});

  TestState copyWith({bool? isVisible, Color? color, double? width, double? height}) {
    return TestState(
      isVisible: isVisible ?? this.isVisible, 
      color: color ?? this.color, 
      width: width ?? this.width, height: 
      height ?? this.height);
  }
}