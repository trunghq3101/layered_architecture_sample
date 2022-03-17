import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/models/todo.model.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/data/user_mode_storage.dart';
import 'package:architecture_bloc_sample/presentation/sandbox_home_page.dart';
import 'package:architecture_bloc_sample/presentation/super_sandbox_home_page.dart';
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
                        value: userModeStorage.currentUserMode,
                        onChanged: _onUserModeDropdownChanged,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<Todo>>(
                      future: todoStorage.readTodoList(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          final todoList = snapshot.data!;
                          return ListView(
                            children: todoList
                                .map(
                                  (e) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Text(e.title),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Something went wrong"),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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
    await todoBloc.addTodo();
    setState(() {});
  }

  Future<void> _onUserModeDropdownChanged(UserMode? userMode) async {
    userModeBloc.changeUserMode(userMode);
    setState(() {});
    if (userMode == null || userMode == UserMode.normal) return;
    await Navigator.of(context).pushNamed(kMapUserModeToPage[userMode]!);
    userModeBloc.changeUserMode(UserMode.normal);
    setState(() {});
  }
}
