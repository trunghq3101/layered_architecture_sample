import 'dart:math';

import 'package:architecture_bloc_sample/data/models/todo.model.dart';

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

const kTodoTitleList2 = [
  'Thai Nguyen',
  'Quang Ninh',
  'Hai Phong',
  'Ha Noi',
  'TP Ho Chi Minh',
  'Be the change that you wish to see in the world.',
  '''In three words I can sum up everything I've learned about life: it goes on.''',
  'A friend is someone who knows all about you and still loves you.',
  'To live is the rarest thing in the world. Most people exist, that is all.',
  'Always forgive your enemies; nothing annoys them so much.'
];

Todo todoCreator() {
  final r = Random();
  final todo = Todo(title: kTodoTitleList[r.nextInt(10)]);
  return todo;
}

Todo todoCreator2() {
  final r = Random();
  final todo = Todo(title: kTodoTitleList2[r.nextInt(10)]);
  return todo;
}
