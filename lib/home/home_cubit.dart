import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/todo.dart';
import 'package:todo_list09flu/home/home_state.dart';
import 'package:todo_list09flu/main.dart';

class HomeCubit extends Cubit<HomeState> {
  
  List<Todo> todoList = [];
  
  HomeCubit():super (HomeState(todoList: [], status: .isLoading));

  void getTodoList() {
    todoList =  appRepository.getTodoList();

    if(todoList.isEmpty) {
      emit(state.copyWith(todoList: [], status: .empty));
    } else {
      emit(state.copyWith(todoList: todoList, status: .success));
    }
  }
}