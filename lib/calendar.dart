import 'package:flutter/material.dart';
import 'CalendarBookingEditor.dart';

class BookCalendar extends StatefulWidget {
  const BookCalendar({super.key});

  @override
  State<BookCalendar> createState() => _BookCalendar();
}

class _BookCalendar extends State<BookCalendar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Buchungs kalender"),
        ),
        body: Column(
          children: [
            Expanded(flex: 2, child: CalendarBookingEditor(setState)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endDocked, // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
