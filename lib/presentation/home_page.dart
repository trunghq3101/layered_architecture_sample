import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoList = todoStorage.readTodoList();
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: todoList
                .map(
                  (e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(e.title),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
