import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<bool> {

  SettingsCubit():super(false) {
    _loadTheme();
  }

  void _loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final isDarkTheme = await preferences.getBool('isDarkTheme') ?? false;
    emit(isDarkTheme);
  }

  void toggleSwitch() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDarkTheme', !state);
    emit(!state);
  }
}