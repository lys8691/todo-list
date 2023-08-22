import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/routes/index.dart';

enum Mode {
  create,
  update,
}

class TodoProvider with ChangeNotifier {
  Mode mode = Mode.create;
  int selectedIndex = -1;
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Todo tempTodo = Todo();
  List<Todo> todos = [];

  onPressCreateButton(BuildContext context) {
    tempTodo = Todo();
    mode = Mode.create;
    selectedDate = DateTime.now();
    focusedDate = DateTime.now();
    Navigator.of(context).pushNamed(Routes.todoScreen);
    notifyListeners();
  }

  onPressUpdateButton(BuildContext context, int index) {
    mode = Mode.update;
    selectedIndex = index;
    tempTodo = todos[index];
    titleController.text = tempTodo.title;
    contentController.text = tempTodo.content;
    focusedDate = DateTime.parse(tempTodo.selectedDate);
    selectedDate = DateTime.parse(tempTodo.selectedDate);

    Navigator.of(context).pushNamed(Routes.todoScreen);
    notifyListeners();
  }

  onDaySelected(DateTime selected, DateTime focused) {
    selectedDate = selected;
    focusedDate = focused;
    notifyListeners();
  }

  onPageChanged(DateTime focused) {
    focusedDate = focused;
    notifyListeners();
  }

  onFormatChanged(CalendarFormat format) {
    format = format;
    notifyListeners();
  }

  onPressRegisterButton(BuildContext context) {
    tempTodo.title = titleController.text;
    tempTodo.content = contentController.text;
    tempTodo.selectedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    debugPrint(
        '${tempTodo.title}, ${tempTodo.content}, ${tempTodo.selectedDate}');

    mode == Mode.create ? todos.add(tempTodo) : todos[selectedIndex] = tempTodo;
    titleController.clear();
    contentController.clear();
    notifyListeners();
    Navigator.of(context).pop();
  }

  onPressRemoveButton(BuildContext context) {
    todos.removeAt(selectedIndex);
    titleController.clear();
    contentController.clear();
    notifyListeners();
    Navigator.of(context).pop();
  }
}