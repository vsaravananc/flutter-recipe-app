import 'package:sqflite/sqflite.dart';

abstract class CreateTable {
  Future<void> createTable(Database db);
}