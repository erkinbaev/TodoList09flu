import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list09flu/database/todo.dart';
import 'package:todo_list09flu/main.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  //выделить память для виджета
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late Timer timer;
  TextEditingController _textEditingController = TextEditingController();

  //виджет появляется в памяти со всеми данными, а также можно подгрузить данные
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //подгрузить данные из сети либо локального хранилища
    //запускать таймеры, анимации, контроллеры, стримы
    //иницилизировать свойства без значений
    print("Add Page - initState");

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      final date = DateTime.now();
      print("${date.minute} : ${date.second}");
    });
  }

  //рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("Add Page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Новая задача"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Введите название задачи",
              ),
            ),
            TextButton(onPressed: _onSaveTap, child: Text("Сохранить"))
          ],
        ),
      ),
    );
  }

  void _onSaveTap() {
    final title = _textEditingController.text;
    final createdAt = DateTime.now().toString();
    appRepository.addTodo(Todo(
      id: 1, 
      title: title, 
      isDone: false, 
      createAt: createdAt, 
      deadline: DateTime.now().toString())
      );

    Navigator.of(context).pop(_textEditingController.text);
  }

  //высвобождает наш виджет из памяти
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //остановить фоновые процессы
    //stream, controller(ы), таймеры и анимации
    print("Add Page - dispose");
    timer.cancel();
    _textEditingController.dispose();
  }
}
