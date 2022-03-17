import 'package:architecture_bloc_sample/business/todo_creator.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

class SandboxTodoBloc {
  SandboxTodoBloc({
    required TodoStorage cachedTodoStorage,
    required TodoStorage persistenceTodoStorage,
  })  : _cachedTodoStorage = cachedTodoStorage,
        _persistenceTodoStorage = persistenceTodoStorage;

  final TodoStorage _cachedTodoStorage;
  final TodoStorage _persistenceTodoStorage;

  Future<void> addTodo() async {
    final todo = todoCreator();
    await _cachedTodoStorage.insertTodo(todo);
  }

  Future<void> save() async {
    final cachedTodoList = await _cachedTodoStorage.readTodoList();
    await _persistenceTodoStorage.saveTodoList(cachedTodoList);
  }
}
