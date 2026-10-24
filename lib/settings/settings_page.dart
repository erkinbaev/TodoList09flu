import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list09flu/settings/settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const SettingsPage({super.key, required this.onThemeChanged});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    "Тёмная тема",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "Переключить тему приложения",
                    style: TextStyle(color: Colors.black54, fontSize: 11),
                  ),
                ],
              ),
              BlocBuilder<SettingsCubit, bool>(
                builder: (context, state) {
                  return Switch(
                    value: state,
                    onChanged: (value) {
                      _onChangeSwitch();
                      widget.onThemeChanged(value);
                      print(value);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChangeSwitch() {
    context.read<SettingsCubit>().toggleSwitch();
  }
}
