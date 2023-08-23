import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/todo_provider.dart';
import 'package:todo_list/routes/index.dart';
import 'package:todo_list/screens/create_todo_screen.dart';
import 'package:todo_list/screens/main_screen.dart';

void main() {
  runApp(
    // for the list of providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-do List',
      // bright mode VS dart mode
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // list of routes
      routes: {
        Routes.mainScreen: (context) => const MainScreen(),
        Routes.todoScreen: (context) => const TodoScreen(),
      },
      // initial page
      initialRoute: Routes.mainScreen,
    );
  }
}
