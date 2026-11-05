import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list09flu/add/add_page.dart';
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/home/home_cubit.dart';
import 'package:todo_list09flu/home/home_state.dart';
import 'package:todo_list09flu/home/test_cubit.dart';
import 'package:todo_list09flu/home/test_state.dart';
import 'package:todo_list09flu/home/todo_tile.dart';
import 'package:todo_list09flu/settings/settings_cubit.dart';
import 'package:todo_list09flu/settings/settings_page.dart';

class MyHomePage extends StatefulWidget {
  final HomeCubit cubit;
  final Function(bool) onThemeChanged;

  const MyHomePage({
    super.key,
    required this.title,
    required this.cubit,
    required this.onThemeChanged,
  });

  final String title;

  //выделить память для виджета
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeCubit cubit;
  DateTime _selectedDate = DateTime.now();

  //виджет появляется в памяти со всеми данными, а также можно подгрузить данные
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //подгрузить данные из сети либо локального хранилища
    //запускать таймеры, анимации, контроллеры, стримы
    //иницилизировать свойства без значений
    print("Home Page - initState");
    cubit = widget.cubit;
    cubit.getTodoListByDate(_selectedDate);
  }

  //рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("Home Page - build");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: _onSettingsTap, icon: Icon(Icons.settings)),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final totalCount = state.todoList.length;

          final completedCount = state.todoList
              .where((element) => element.isDone)
              .length;

          final double progress = totalCount == 0
              ? 0.0
              : completedCount / totalCount;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressCard(
                totalCount: totalCount,
                completedCount: completedCount,
                progress: progress,
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Список задач",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: state.status == .empty
                    ? const Center(child: Text("На выбранный день нет задач!"))
                    : ListView.builder(
                        itemCount: state.todoList.length,
                        itemBuilder: (context, index) {

                          return Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child:  TodoTile(
                            title: state.todoList[index].title,
                            date: state.todoList[index].deadline,
                            isDone: state.todoList[index].isDone,
                            onChanged: (value) {
                              print(value);
                              cubit.updateTodoStatus(state.todoList[index].id, value ?? false, _selectedDate);
                            },
                          )
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProgressCard({
    required int totalCount,
    required int completedCount,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: _onDateTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Сегодня", style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(
                      "$completedCount из $totalCount выполнено",
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFF89929B),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF0A72FF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onDateTap() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context, 
      initialDate: _selectedDate,
      firstDate: DateTime(2020), 
      lastDate: DateTime(2050)
      );

      if (selectedDate == null) return;

      setState(() {
        _selectedDate = selectedDate;
      });

      cubit.getTodoListByDate(selectedDate);
  }

  // @override
  // Widget build(BuildContext context) {
  //   print("Home Page - build");
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       title: Text(widget.title),
  //     ),
  //     body: BlocBuilder<TestCubit, TestState>(

  //       builder: (context, state) {
  //         return Center(
  //           child: Column(
  //             mainAxisAlignment: .center,
  //             children: [
  //               Visibility(child: Text("Additional info"), visible: state.isVisible),
  //               TextButton(
  //                 onPressed: onHideTap,
  //                 child: Text(state.isVisible ? "Скрыть" : "Показать"),
  //               ),
  //               Container(width: 300, height: 100, color: state.color),
  //               TextButton(onPressed: onPaintTap, child: Text("Покрасить")),
  //               Container(width: state.width, height: state.height, color: Colors.pink),
  //               TextButton(
  //                 onPressed: onSizeTap,
  //                 child: Text("Поменять размер"),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  // }

  // void onHideTap() {
  //   cubit.changeVisibility();
  // }

  // void onPaintTap() {
  //   cubit.changeColors();
  // }

  //void onSizeTap() {
  //cubit.changeSize();
  // }

  void _onAddTap() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AddPage()));
    cubit.getTodoListByDate(_selectedDate);
    if (result != null) {
      print("$result");
    }
  }

  void _onSettingsTap() {
    final settingsCubit = SettingsCubit();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => settingsCubit,
          child: SettingsPage(onThemeChanged: widget.onThemeChanged),
        ),
      ),
    );
  }

  //высвобождает наш виджет из памяти
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //остановить фоновые процессы
    //stream, controller(ы), таймеры и анимации
    print("Home Page - dispose");
  }
}

extension on Random {
  void nextInt(int length) {}
}
