import 'package:architecture_bloc_sample/business/todo_creator.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

class SuperSandboxTodoBloc {
  SuperSandboxTodoBloc({
    required TodoStorage superSandboxTodoStorage,
    required TodoStorage normalTodoStorage,
  })  : _superSandboxTodoStorage = superSandboxTodoStorage,
        _normalTodoStorage = normalTodoStorage;

  final TodoStorage _superSandboxTodoStorage;
  final TodoStorage _normalTodoStorage;

  Future<void> addTodo() async {
    final todo = todoCreator2();
    await _superSandboxTodoStorage.insertTodo(todo);
  }
}
