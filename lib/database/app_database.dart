import 'package:todo_list09flu/database/todo.dart';

class AppDatabase {
  List<Todo> _todoList = [
    Todo(id: 1, title: "Купить телефон", isDone: false, createAt: "31.08.2026", deadline: "01.10.2026"),
    Todo(id: 2, title: "Посмотреть фильм Дюна", isDone: false, createAt: "16.10.2026", deadline: "18.10.2026"),
    Todo(id: 3, title: "Записаться в зал", isDone: true, createAt: "25.05.2026", deadline: "01.06.2026"),
    ];

    List<Todo> getTodoList() {
      return _todoList;
    }
}