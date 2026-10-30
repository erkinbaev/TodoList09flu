
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/todo.dart';

abstract class AppRepository {
  List<Todo> getTodoList();

  void addTodo(Todo todo);

  void updateTodo(int id, String title, String deadline);

  void deleteTodo(int id);
}

class AppRepositoryImpl extends AppRepository {
  final AppDatabase db;

  AppRepositoryImpl({required this.db});

  @override
  List<Todo> getTodoList() {
    return db.getTodoList();
  }

  @override
  void addTodo(Todo todo) {
    db.addTodo(todo);
  }

  @override
  void updateTodo(int id, String title, String deadline) {
    // TODO: implement updateTodo
  }

  @override
  void deleteTodo(int id) {
    // TODO: implement deleteTodo
  }
}