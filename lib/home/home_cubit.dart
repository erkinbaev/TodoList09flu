import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/todo.dart';
import 'package:todo_list09flu/home/home_state.dart';
import 'package:todo_list09flu/main.dart';
import 'dart:math';

class HomeCubit extends Cubit<HomeState> {
  
  
  
  HomeCubit():super (HomeState(todoList: [], status: .isLoading));

  void getTodoListByDate(DateTime selectedDate) {
    final todoList =  appRepository.getTodoListByDate(selectedDate);
    emit(state.copyWith(todoList: todoList, status: todoList.isEmpty ? .empty : .success));
  }

  void updateTodoStatus(int id, bool isDone, DateTime selectedDate) {
    appRepository.updateTodoStatus(id, isDone);

    getTodoListByDate(selectedDate);
  }

//   void checkConnection() {
//     final connection = Random().nextInt(599) + 200;
//     print(connection);
//   if (connection >= 200 && connection <= 299) {
//     print("success");
//   } else if (connection >= 400 && connection <= 499) {
//     print("404");
//   } else if (connection >= 500 && connection <= 599) {
//     throw NetworkError("Server not responde");
//   }
// }

}

class NetworkError implements Exception {
  String message;

  NetworkError(this.message);

  String toString() {
    return message;
  }
}