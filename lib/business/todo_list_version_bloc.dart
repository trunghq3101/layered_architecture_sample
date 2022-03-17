import 'package:architecture_bloc_sample/data/models/todo_list_version.model.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

class TodoListVersionBloc {
  TodoListVersionBloc({
    required TodoStorage todoStorage,
  }) : _todoStorage = todoStorage;

  bool _selectionShowing = false;
  final TodoStorage _todoStorage;

  bool get selectionShowing => _selectionShowing;

  void toggleSelection() {
    _selectionShowing = !_selectionShowing;
  }

  Future<void> selectVerion(TodoListVersion version) async {
    toggleSelection();
    await _todoStorage.saveTodoList(version.todos);
  }
}
