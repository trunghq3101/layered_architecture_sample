import 'package:architecture_bloc_sample/business/super_sandbox_todo_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

import 'widgets/add_todo_button.dart';
import 'widgets/todo_list_view.dart';

class SuperSandboxHomePage extends StatefulWidget {
  const SuperSandboxHomePage({Key? key}) : super(key: key);

  @override
  State<SuperSandboxHomePage> createState() => _SuperSandboxHomePageState();
}

class _SuperSandboxHomePageState extends State<SuperSandboxHomePage> {
  final TodoStorage _todoStorage = getIt.get(instanceName: kCached);
  final UserModeBloc _userModeBloc = getIt.get();
  final SuperSandboxTodoBloc _todoBloc = getIt.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Super Sandbox'),
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
