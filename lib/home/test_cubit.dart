import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/home/test_state.dart';

class TestCubit extends Cubit<TestState> {
List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.green, Colors.black];

  TestCubit():super(TestState(isVisible: true, color: Colors.black, width: 300, height: 200));

  void changeVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  void changeColors() {
    final color = colors[Random().nextInt(colors.length)];
    emit(state.copyWith(color: color));
  }

  void changeSize() {
    final w = Random().nextInt(300);
    final h = Random().nextInt(100);
    emit(state.copyWith(width: w.toDouble(), height: h.toDouble()));
  }
}