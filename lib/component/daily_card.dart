import 'package:daily_diary/screen/day_write_diary_screen.dart';
import 'package:flutter/material.dart';

class DailyCard extends StatefulWidget {
  String content;
  String date;
  int diaryid;

  DailyCard({
    Key? key,
    required this.content,
    required this.date,
    required this.diaryid,
  }) : super(key: key);

  @override
  State<DailyCard> createState() => _DailyCardState();
}

class _DailyCardState extends State<DailyCard> {
  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
      color: Colors.purple,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return DayWriteDiaryScreen(
                diaryId: widget.diaryid,
                content: widget.content,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(8.0),
          color: Colors.purple[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.content,
                style: ts,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                widget.date,
                style: ts.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
