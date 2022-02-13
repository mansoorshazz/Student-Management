import 'package:flutter/material.dart';

import 'package:week_5/home.dart';
import 'package:week_5/model.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(StudentsAdapter().typeId)) {
    Hive.registerAdapter(StudentsAdapter());
  }
  await Hive.openBox<Students>('records');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
