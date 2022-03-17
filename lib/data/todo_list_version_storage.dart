import 'dart:convert';
import 'dart:io';

import 'package:architecture_bloc_sample/data/models/todo.model.dart';
import 'package:architecture_bloc_sample/data/models/todo_list_version.model.dart';
import 'package:path_provider/path_provider.dart';

abstract class TodoListVersionStorage {
  Future<List<TodoListVersion>> readVersionList();

  Future<void> saveVersion(List<Todo> todoList);
}

class FileSystemTodoListVersionStorage extends TodoListVersionStorage {
  @override
  Future<List<TodoListVersion>> readVersionList() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      final List<dynamic> jsonArray = jsonDecode(content);
      return jsonArray
          .map(
            (jsonObject) => TodoListVersion.fromJson(jsonObject),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/todoListVersionList.json');
  }

  @override
  Future<void> saveVersion(List<Todo> todoList) async {
    final latestTodoListVersionList = await readVersionList();
    latestTodoListVersionList.add(TodoListVersion(
        createdAt: DateTime.now().millisecondsSinceEpoch, todos: todoList));
    try {
      final file = await _localFile;
      final jsonArray = latestTodoListVersionList
          .map(
            (e) => e.toJson(),
          )
          .toList();
      await file.writeAsString(jsonEncode(jsonArray));
    } catch (e) {
      return;
    }
  }
}
