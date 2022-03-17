import 'package:architecture_bloc_sample/business/todo_creator.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

class TodoBloc {
  final TodoStorage _todoStorage;

  TodoBloc({required TodoStorage todoStorage}) : _todoStorage = todoStorage;

  Future<void> addTodo() async {
    final todo = todoCreator();
    await _todoStorage.insertTodo(todo);
  }
}
