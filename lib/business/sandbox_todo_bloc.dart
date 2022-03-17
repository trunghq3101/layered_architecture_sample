import 'package:architecture_bloc_sample/business/todo_creator.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

class SandboxTodoBloc {
  SandboxTodoBloc({
    required TodoStorage sandboxTodoStorage,
    required TodoStorage normalTodoStorage,
  })  : _sandboxTodoStorage = sandboxTodoStorage,
        _normalTodoStorage = normalTodoStorage;

  final TodoStorage _sandboxTodoStorage;
  final TodoStorage _normalTodoStorage;

  Future<void> addTodo() async {
    final todo = todoCreator();
    await _sandboxTodoStorage.insertTodo(todo);
  }

  Future<void> save() async {
    final sandboxTodoList = await _sandboxTodoStorage.readTodoList();
    await _normalTodoStorage.saveTodoList(sandboxTodoList);
  }
}
