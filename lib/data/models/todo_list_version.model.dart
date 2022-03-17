import 'todo.model.dart';

class TodoListVersion {
  int createdAt;
  List<Todo> todos;

  TodoListVersion({required this.createdAt, required this.todos});

  @override
  String toString() {
    return 'TodoListVersion(createdAt: $createdAt, todos: $todos)';
  }

  factory TodoListVersion.fromJson(Map<String, dynamic> json) {
    return TodoListVersion(
      createdAt: json['createdAt'] as int,
      todos: (json['todos'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'todos': todos.map((e) => e.toJson()).toList(),
      };

  TodoListVersion copyWith({
    int? createdAt,
    List<Todo>? todos,
  }) {
    return TodoListVersion(
      createdAt: createdAt ?? this.createdAt,
      todos: todos ?? this.todos,
    );
  }
}
