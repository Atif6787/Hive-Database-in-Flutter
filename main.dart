import 'package:flutter/material.dart';
import 'package:flutter_api/Hive%20Database/HiveDatabase.dart';
import 'package:flutter_api/Hive%20Database/HiveDatabase_Model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveDataModelAdapter());
  await Hive.openBox<HiveDataModel>('hiveBox');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HiveDatabase_2());
  }
}
