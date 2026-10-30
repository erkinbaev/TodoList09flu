import 'package:todo_list09flu/database/todo.dart';
import 'package:hive/hive.dart';

//JSON - JAVASCRIPT OBJECT NOTATION
//CRUD OPERATIONS

class AppDatabase {
  final Box box = Hive.box('todoBox');

  AppDatabase() {
    loadTodos();
  }

  List<Todo> _todoList = [
    // Todo(id: 1, title: "Купить телефон", isDone: false, createAt: "31.08.2026", deadline: "01.10.2026"),
    // Todo(id: 2, title: "Посмотреть фильм Дюна", isDone: false, createAt: "16.10.2026", deadline: "18.10.2026"),
    // Todo(id: 3, title: "Записаться в зал", isDone: true, createAt: "25.05.2026", deadline: "01.06.2026"),
  ];

  void saveTodos() {
    final data = _todoList.map((todo) {
      return {
        "id": todo.id,
        "title": todo.title,
        "isDone": todo.isDone,
        "createdAt": todo.createAt,
        "deadline": todo.deadline,
      };
    }).toList();

    box.put('todos', data);
  }

  void loadTodos() {
    final data = box.get('todos', defaultValue: []);

    _todoList = List<Map>.from(data).map((e) {
      return Todo(
        id: e['id'],
        title: e['title'],
        isDone: e['isDone'],
        createAt: e['createdAt'],
        deadline: e['deadline'],
      );
    }).toList();
  }

  //READ
  List<Todo> getTodoList() {
    return _todoList;
  }

  //CREATE 
  void addTodo(Todo todo) {
    _todoList.insert(0, todo);
    saveTodos();
  }

  //UPDATE
  void updateTodo(int id, String title, String deadline) {
    //Пройтись по списку и сравить id и заменить новыми данными
    
    saveTodos();
  }

  //DELETE 
  void deleteTodo(int id) {
     //Пройтись по списку и сравить id и удалить из List
  }
}
