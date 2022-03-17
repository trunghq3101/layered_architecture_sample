import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/presentation/widgets/todo_list_view.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

import 'widgets/add_todo_button.dart';

class SandboxHomePage extends StatefulWidget {
  const SandboxHomePage({Key? key}) : super(key: key);

  @override
  State<SandboxHomePage> createState() => _SandboxHomePageState();
}

class _SandboxHomePageState extends State<SandboxHomePage> {
  final TodoStorage _todoStorage = getIt.get(instanceName: kCached);
  final UserModeBloc _userModeBloc = getIt.get();
  final TodoBloc _todoBloc = getIt.get(instanceName: kCached);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sandbox'),
        leading: BackButton(
          onPressed: () {
            _userModeBloc.exitUserMode();
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: Stack(
        children: [
          TodoListView(todoStorage: _todoStorage),
          Align(
            alignment: Alignment.bottomRight,
            child: AddTodoButton(
              addTodo: _todoBloc.addTodo,
              onAddedSuccess: () {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
