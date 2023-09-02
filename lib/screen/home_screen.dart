import 'package:daily_diary/database/drift_database.dart';
import 'package:daily_diary/screen/day_write_diary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../component/daily_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String pickYearandMonth =
        '${now.year.toString()}년 ${now.month.toString()}월';

    TextStyle ts = TextStyle(
      color: Colors.purple,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) {
                  return DayWriteDiaryScreen();
                },
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  '로고이미지',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: GetIt.I<LocalDatabase>().getDiaryAll(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Text('에러발생');
                }

                if (snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text('일기를 작성해보세요!'),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            // 나중에 전체 보기, 연월보기 옵션을 나누는것도 낫벳할지도.
                            // Text(
                            //   pickYearandMonth,
                            //   style: ts,
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final diaryData = snapshot.data![index];
                            final content = diaryData.content;
                            final date = DateFormat('d일 HH:MM')
                                .format(diaryData.createdAt)
                                .toString();
                            return DailyCard(
                              content: content,
                              date: date,
                              diaryid: diaryData.id,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
