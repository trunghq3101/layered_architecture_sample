import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/presentation/widgets/todo_list_view.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

class SandboxHomePage extends StatefulWidget {
  const SandboxHomePage({Key? key}) : super(key: key);

  @override
  State<SandboxHomePage> createState() => _SandboxHomePageState();
}

class _SandboxHomePageState extends State<SandboxHomePage> {
  final TodoStorage _todoStorage = getIt.get(instanceName: 'cached');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sandbox'),
      ),
      body: Stack(
        children: [
          TodoListView(todoStorage: _todoStorage),
        ],
      ),
    );
  }
}
