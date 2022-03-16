import 'package:architecture_bloc_sample/data/todo.model.dart';
import 'package:flutter/material.dart';

final todoList = [
  Todo(title: 'Do something 1'),
  Todo(title: 'Do something 2'),
  Todo(title: 'Do something 3'),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
