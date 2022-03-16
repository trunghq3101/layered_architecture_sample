import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/data/models/todo.model.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              FutureBuilder<List<Todo>>(
                future: todoStorage.readTodoList(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final todoList = snapshot.data!;
                    return ListView(
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
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: FloatingActionButton(
                    onPressed: _onAddTodoButtonPressed,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAddTodoButtonPressed() async {
    await todoBloc.addTodo();
    setState(() {});
  }
}
