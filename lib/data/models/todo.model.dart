class Todo {
  String title;

  Todo({required this.title});

  @override
  String toString() => 'Todo(title: $title)';

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json['title'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
      };

  Todo copyWith({
    required String title,
  }) {
    return Todo(
      title: title,
    );
  }

  @override
  bool operator ==(other) {
    if (other is! Todo) {
      return false;
    }
    return title == (other).title;
  }

  @override
  int get hashCode => title.hashCode;
}
