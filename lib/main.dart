import 'package:daily_diary/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_diary/database/drift_database.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = LocalDatabase();

  // 하위에서 데이터 베이스 접근할수있게 해줌
  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
