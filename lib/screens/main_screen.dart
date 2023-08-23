import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/todo_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get provider for state management
    final tp = Provider.of<TodoProvider>(context);

    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Todo List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        // Make scroll view possible for the screen
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Show the list of created Todos
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => tp.onPressUpdateButton(context, index),
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade200),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tp.todos[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(tp.todos[index].content),
                                ],
                              ),
                              Text(tp.todos[index].selectedDate),
                            ],
                          ),
                        ),
                      );
                    },
                    // space between Todos
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 24,
                      );
                    },
                    itemCount: tp.todos.length),
              ),
            ],
          ),
        ),
      ),
      // Button to create new Todos
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () => tp.onPressCreateButton(context),
      ),
    );
  }
}
