import 'dart:ffi';
import 'dart:io';

import 'package:daily_diary/model/diarys.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Diarys,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  //insert
  Future<int> createDiary(DiaryCompanion data) => into(diary).insert(data); // insert한 값의 primary key를 반환

  //select

  Future<List<DiaryData>> getDiaryAll() =>
      (select(diary)..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
      

  Future<DiaryData> getDiaryByYearMonth(int id) {

      return (select(diary)..where((tbl) => tbl.id.equals(id))).getSingle();}

  Future<DiaryData> getDiaryById(int id) =>
      (select(diary)..where((tbl) => tbl.id.equals(id))).getSingle();

  //update

  Future<int> updateScheduleById(int id, DiaryCompanion data) =>
      (update(diary)..where((tbl) => tbl.id.equals(id))).write(data);




  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    },
  );
}
