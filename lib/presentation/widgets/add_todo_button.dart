import 'package:flutter/material.dart';

typedef AddTodo = Future<void> Function();
typedef OnAddedSuccess = void Function();

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    Key? key,
    required AddTodo addTodo,
    OnAddedSuccess? onAddedSuccess,
  })  : _addTodo = addTodo,
        _onAddedSuccess = onAddedSuccess,
        super(key: key);

  final AddTodo _addTodo;
  final OnAddedSuccess? _onAddedSuccess;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: FloatingActionButton(
        onPressed: _onAddTodoButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _onAddTodoButtonPressed() async {
    await _addTodo();
    _onAddedSuccess?.call();
  }
}
