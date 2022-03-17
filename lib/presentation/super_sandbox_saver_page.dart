import 'package:architecture_bloc_sample/business/super_sandbox_todo_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/presentation/home_page.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

class SuperSandboxSaverPage extends StatelessWidget {
  const SuperSandboxSaverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SuperSandboxTodoBloc _todoBloc = getIt.get();
    final UserModeBloc _userModeBloc = getIt.get();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Sandbox Saver'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 10),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    _onSaveACopyPressed(context, _todoBloc, _userModeBloc);
                  },
                  child: const Text('Save a copy'),
                ),
              ),
              const Spacer(flex: 1),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    _onOnlyRemoveRedPressed(context, _todoBloc, _userModeBloc);
                  },
                  child: const Text('Only remove Red'),
                ),
              ),
              const Spacer(flex: 1),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    _onRemoveRedAndKeepGreenPressed(
                        context, _todoBloc, _userModeBloc);
                  },
                  child: const Text('Remove Red & Keep Green'),
                ),
              ),
              const Spacer(flex: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSaveACopyPressed(
    BuildContext context,
    SuperSandboxTodoBloc todoBloc,
    UserModeBloc userModeBloc,
  ) async {
    await todoBloc.saveACopy();
    _exitMode(context, userModeBloc);
  }

  Future<void> _onOnlyRemoveRedPressed(
    BuildContext context,
    SuperSandboxTodoBloc todoBloc,
    UserModeBloc userModeBloc,
  ) async {
    await todoBloc.onlyRemoveRed();
    _exitMode(context, userModeBloc);
  }

  Future<void> _onRemoveRedAndKeepGreenPressed(
    BuildContext context,
    SuperSandboxTodoBloc todoBloc,
    UserModeBloc userModeBloc,
  ) async {
    await todoBloc.removeRedAndKeepGreen();
    _exitMode(context, userModeBloc);
  }

  void _exitMode(BuildContext context, UserModeBloc userModeBloc) {
    userModeBloc.exitUserMode();
    Navigator.of(context).popUntil(
      (route) => route.settings.name == '$HomePage',
    );
  }
}
