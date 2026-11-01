import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list09flu/database/app_database.dart';
import 'package:todo_list09flu/database/app_repository.dart';
import 'package:todo_list09flu/home/home_cubit.dart';
import 'package:todo_list09flu/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/home/test_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:todo_list09flu/utils/app_snackbar.dart';

late final AppDatabase appDatabase;
late final AppRepositoryImpl appRepository;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
  print("dark theme: $isDarkTheme");

  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  appDatabase = AppDatabase();
  appRepository = AppRepositoryImpl(db: appDatabase);

  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  bool isDarkTheme = false;
   MyApp({super.key, required this.isDarkTheme});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  HomeCubit cubit = HomeCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: widget.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: BlocProvider(create: (_) => cubit, child:  MyHomePage(title: "", cubit: cubit, onThemeChanged: _changeTheme)),
    );
  }

  void _changeTheme(bool isDarkTheme) {
    setState(() {
      widget.isDarkTheme = isDarkTheme;
    });
  }
}

