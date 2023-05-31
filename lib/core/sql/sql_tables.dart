import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class SqlTables {
  createTables() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ecommerce1.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE Cart("id" INTEGER PRIMARY KEY,"idProduct" INTEGER UNIQUE , "userId" TEXT,"title" TEXT, "price" DOUBLE , "image" TEXT, "count" INTEGER)',
        );

      },
      version: 1,
    );
  }

}
