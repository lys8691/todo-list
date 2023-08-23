import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/providers/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    // call provider for state management + actions
    final tp = Provider.of<TodoProvider>(context);

    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create Todo'),
      ),
      // Body
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 16,
          right: 16,
          bottom: 50,
        ),
        child: Column(
          children: [
            // TextFormField for Title
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                controller: tp.titleController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  hintText: '제목을 입력해주세요',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            // TextFormField for Content
            SizedBox(
              height: 100,
              width: double.infinity,
              child: TextFormField(
                expands: true,
                minLines: null,
                maxLines: null,
                controller: tp.contentController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: '내용을 입력해주세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            // Calender to select date
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: tp.focusedDate,
              selectedDayPredicate: (day) {
                return isSameDay(tp.selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) =>
                  tp.onDaySelected(selectedDay, focusedDay),
              onPageChanged: (focusedDay) => tp.onPageChanged(focusedDay),
              calendarFormat: tp.format,
              onFormatChanged: (CalendarFormat format) =>
                  tp.onFormatChanged(format),
            ),
            const Spacer(),
            // Button for Register or Update
            MaterialButton(
              color: Colors.black,
              minWidth: double.infinity,
              height: 50,
              onPressed: () => tp.onPressRegisterButton(context),
              child: Text(
                tp.mode == Mode.create ? '등록하기' : '수정하기',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Button for delete
            Visibility(
              visible: tp.mode == Mode.update,
              child: MaterialButton(
                color: Colors.red,
                minWidth: double.infinity,
                height: 50,
                onPressed: () => tp.onPressRemoveButton(context),
                child: const Text(
                  '삭제하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
