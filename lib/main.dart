import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/injector/injector.dart' as di;
import 'core/sql/sql_tables.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SqlTables().createTables();
  await di.init();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? login = prefs.getBool('login');

  runApp( MyApp(loggedIn:login??false));
}

