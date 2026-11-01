import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/todo.dart';
import 'package:todo_list09flu/home/home_state.dart';
import 'package:todo_list09flu/main.dart';
import 'dart:math';

class HomeCubit extends Cubit<HomeState> {
  
  List<Todo> todoList = [];
  
  HomeCubit():super (HomeState(todoList: [], status: .isLoading));

  void getTodoList() {
    todoList =  appRepository.getTodoList();

    // try {
    //   checkConnection();
    //   emit(state.copyWith(todoList: todoList, status: .success));
    // } catch(e) {
    //   emit(state.copyWith(status: .error));
    // }

    if(todoList.isEmpty) {
      emit(state.copyWith(todoList: [], status: .empty));
    } else {
      emit(state.copyWith(todoList: todoList, status: .success));
    }
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