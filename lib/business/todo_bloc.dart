import 'dart:math';

import 'package:architecture_bloc_sample/data/models/todo.model.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';

const kTodoTitleList = [
  'Be yourself; everyone else is already taken.',
  '''Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.''',
  'So many books, so little time.',
  'A room without books is like a body without a soul.',
  'You only live once, but if you do it right, once is enough.',
  'Be the change that you wish to see in the world.',
  '''In three words I can sum up everything I've learned about life: it goes on.''',
  'A friend is someone who knows all about you and still loves you.',
  'To live is the rarest thing in the world. Most people exist, that is all.',
  'Always forgive your enemies; nothing annoys them so much.'
];

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
    return kTodoTitleList[r.nextInt(10)];
  }
}
