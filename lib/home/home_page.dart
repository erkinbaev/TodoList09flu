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
import 'package:todo_list09flu/settings/settings_cubit.dart';
import 'package:todo_list09flu/settings/settings_page.dart';

class MyHomePage extends StatefulWidget {
  final HomeCubit cubit;
  final Function(bool) onThemeChanged;

  const MyHomePage({super.key, required this.title, required this.cubit, required this.onThemeChanged});

  final String title;

  //выделить память для виджета
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeCubit cubit;

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
    cubit.getTodoList();
  }

  //рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("Home Page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [IconButton(onPressed: _onSettingsTap, icon: Icon(Icons.settings))],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == .empty) {
            return Center(child: Text("У вас еще нет задач"));
          } else if (state.status == .isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: ListView.builder(
                itemCount: state.todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(state.todoList[index].title));
                },
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
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
    if (result != null) {
      print("$result");
    }
  }

  void _onSettingsTap() {
    final settingsCubit = SettingsCubit();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(create: (_) => settingsCubit, child: SettingsPage(onThemeChanged: widget.onThemeChanged))));
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
