import 'package:flutter/material.dart';
import 'package:todo_list09flu/add/add_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

//выделить память для виджета
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    //setState(() {
     //_counter++;
    //});
     _counter++;
     print("$_counter");
  }

  //виджет появляется в памяти со всеми данными, а также можно подгрузить данные
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //подгрузить данные из сети либо локального хранилища
    //запускать таймеры, анимации, контроллеры, стримы
    //иницилизировать свойства без значений
    print("Home Page - initState");
  }

//рисует интерфейс
  @override
  Widget build(BuildContext context) {
    print("Home Page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  // }

  void _onAddTap() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPage()));
    if (result != null) {
      print("$result");
    }
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
