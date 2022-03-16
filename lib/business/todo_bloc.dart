import 'dart:math';

import 'package:architecture_bloc_sample/data/models/todo.model.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

final TodoBloc todoBloc = TodoBloc(todoStorage: todoStorage);

class TodoBloc {
  final TodoStorage _todoStorage;

  TodoBloc({required TodoStorage todoStorage}) : _todoStorage = todoStorage;

  Future<void> addTodo() async {
    final randomTitle = _getRandomTitle();
    final todo = Todo(title: randomTitle);
    await _todoStorage.insertTodo(todo);
  }

  String _getRandomTitle() {
    final r = Random();
    return String.fromCharCodes(
      List.generate(
        50,
        (index) => r.nextInt(33) + 89,
      ),
    );
  }
}
