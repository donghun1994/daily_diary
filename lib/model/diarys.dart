import 'package:drift/drift.dart';


class Diarys extends Table {
  //PRIMAY_KEY
  IntColumn get id => integer().autoIncrement()();
  
  //내용
  TextColumn get content => text()();

  //생성 날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  
}