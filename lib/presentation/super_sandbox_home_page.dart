import 'package:architecture_bloc_sample/business/models/super_sandbox_todo.model.dart';
import 'package:architecture_bloc_sample/business/super_sandbox_todo_bloc.dart';
import 'package:architecture_bloc_sample/business/todo_list_version_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/models/todo_list_version.model.dart';
import 'package:architecture_bloc_sample/data/todo_list_version_storage.dart';
import 'package:architecture_bloc_sample/presentation/super_sandbox_saver_page.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

import 'widgets/add_todo_button.dart';

class SuperSandboxHomePage extends StatefulWidget {
  const SuperSandboxHomePage({Key? key}) : super(key: key);

  @override
  State<SuperSandboxHomePage> createState() => _SuperSandboxHomePageState();
}

class _SuperSandboxHomePageState extends State<SuperSandboxHomePage> {
  final UserModeBloc _userModeBloc = getIt.get();
  final SuperSandboxTodoBloc _todoBloc = getIt.get();
  final TodoListVersionBloc _todoListVersionBloc = getIt.get();
  final TodoListVersionStorage _todoListVersionStorage =
      getIt.get(instanceName: kFileSystem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Super Sandbox'),
        leading: BackButton(
          onPressed: () {
            _onBackPressed();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _todoListVersionBloc.toggleSelection();
              setState(() {});
            },
            icon: const Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('$SuperSandboxSaverPage');
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<List<SuperSandboxTodo>>(
              future: _todoBloc.readTodoList(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final todoList = snapshot.data!;
                  return ListView(
                    children: todoList
                        .map(
                          (e) => Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: _todoColor(e),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
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
            Visibility(
              visible: _todoListVersionBloc.selectionShowing,
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: SizedBox.expand(
                  child: Card(
                    child: FutureBuilder<List<TodoListVersion>>(
                        future: _todoListVersionStorage.readVersionList(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            final todoListVersionList = snapshot.data!;
                            return ListView(
                              children: todoListVersionList
                                  .map(
                                    (e) => ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Text(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            e.createdAt,
                                          ).toString(),
                                        ),
                                      ),
                                      onTap: () {
                                        _onVersionSelected(e);
                                      },
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
                        }),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !_todoListVersionBloc.selectionShowing,
              child: Align(
                alignment: Alignment.bottomRight,
                child: AddTodoButton(
                  addTodo: _todoBloc.addTodo,
                  onAddedSuccess: () {
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _todoColor(SuperSandboxTodo todo) {
    return todo.matched ? Colors.red : Colors.green;
  }

  Future<void> _onBackPressed() async {
    await _todoBloc.onExit();
    _userModeBloc.exitUserMode();
    Navigator.of(context).maybePop();
  }

  Future<void> _onVersionSelected(TodoListVersion version) async {
    await _todoListVersionBloc.selectVerion(version);
    setState(() {});
  }
}
