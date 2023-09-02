import 'package:daily_diary/database/drift_database.dart';
import 'package:daily_diary/screen/home_screen.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DayWriteDiaryScreen extends StatefulWidget {
  final int? diaryId;
  final String? content;

  DayWriteDiaryScreen({
    super.key,
    this.diaryId,
    this.content,
  });

  @override
  State<DayWriteDiaryScreen> createState() => _DayWriteDiaryScreenState();
}

class _DayWriteDiaryScreenState extends State<DayWriteDiaryScreen> {
  bool submit = false;
  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        submit = myController.text.isNotEmpty;
      });
    });

    if (widget.content != null) {
      myController.text = widget!.content!;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.purple[300],
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
              onPressed: submit
                  ? () async {
                      var content = myController.text;

                      if (widget.diaryId == null) {
                        await GetIt.I<LocalDatabase>().createDiary(
                            DiaryCompanion(content: Value(content)));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                      } else {
                        await GetIt.I<LocalDatabase>().updateScheduleById(
                            widget.diaryId!,
                            DiaryCompanion(
                                id: Value(widget.diaryId!),
                                content: Value(content)));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                      }
                    }
                  : null,
              child: Text(
                submit ? '저장' : '',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 500,
                    color: Colors.purple[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: myController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          decorationThickness: 0,
                        ),
                        maxLines: 20,
                        decoration: InputDecoration(
                          hintText: '오늘을 한 줄로 표현해본다면?',
                          hintStyle: TextStyle(
                            color: Colors.purple,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
