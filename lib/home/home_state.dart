import 'package:todo_list09flu/database/todo.dart';

enum HomeStatus {
  success,
  empty,
  isLoading
}

class HomeState {
  final List<Todo> todoList;
  final HomeStatus status;

  const HomeState({required this.todoList, required this.status});

  HomeState copyWith({List<Todo>? todoList, HomeStatus? status}) {
    return HomeState(todoList: todoList ?? this.todoList, status: status ?? this.status);
  }
}