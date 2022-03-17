import 'package:architecture_bloc_sample/business/models/super_sandbox_todo.model.dart';
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

  Future<List<SuperSandboxTodo>> readTodoList() async {
    final superSandboxTodoList = await _superSandboxTodoStorage.readTodoList();
    final normalSandboxTodoList = await _normalTodoStorage.readTodoList();
    return superSandboxTodoList
        .map(
          (e) => SuperSandboxTodo(
            title: e.title,
            matched: normalSandboxTodoList.contains(e),
          ),
        )
        .toList();
  }

  Future<void> onExit() async {
    final superSandboxTodoList = await _superSandboxTodoStorage.readTodoList();
    final normalSandboxTodoList = await _normalTodoStorage.readTodoList();
    normalSandboxTodoList.removeWhere((e) => superSandboxTodoList.contains(e));
    await _normalTodoStorage.saveTodoList(normalSandboxTodoList);
  }
}
