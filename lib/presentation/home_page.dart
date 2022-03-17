import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/data/user_mode_storage.dart';
import 'package:architecture_bloc_sample/presentation/sandbox_home_page.dart';
import 'package:architecture_bloc_sample/presentation/super_sandbox_home_page.dart';
import 'package:architecture_bloc_sample/presentation/widgets/todo_list_view.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

final kMapUserModeToPage = {
  UserMode.normal: '$HomePage',
  UserMode.sandbox: '$SandboxHomePage',
  UserMode.superSandbox: '$SuperSandboxHomePage',
};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoStorage _todoStorage = getIt.get(instanceName: 'fileSystem');
  final UserModeStorage _userModeStorage = getIt.get();
  final TodoBloc _todoBloc = getIt.get();
  final UserModeBloc _userModeBloc = getIt.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DropdownButton<UserMode>(
                        items: const <DropdownMenuItem<UserMode>>[
                          DropdownMenuItem(
                            child: Text('Normal'),
                            value: UserMode.normal,
                          ),
                          DropdownMenuItem(
                            child: Text('Sandbox'),
                            value: UserMode.sandbox,
                          ),
                          DropdownMenuItem(
                            child: Text('Super Sandbox'),
                            value: UserMode.superSandbox,
                          ),
                        ],
                        value: _userModeStorage.currentUserMode,
                        onChanged: _onUserModeDropdownChanged,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TodoListView(todoStorage: _todoStorage),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: FloatingActionButton(
                    onPressed: _onAddTodoButtonPressed,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAddTodoButtonPressed() async {
    await _todoBloc.addTodo();
    setState(() {});
  }

  Future<void> _onUserModeDropdownChanged(UserMode? userMode) async {
    _userModeBloc.changeUserMode(userMode);
    setState(() {});
    if (userMode == null || userMode == UserMode.normal) return;
    await Navigator.of(context).pushNamed(kMapUserModeToPage[userMode]!);
    _userModeBloc.changeUserMode(UserMode.normal);
    setState(() {});
  }
}
