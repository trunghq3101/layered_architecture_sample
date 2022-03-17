import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/data/user_mode_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupMainDeps() {
  getIt.registerSingleton<TodoStorage>(
    FileSystemTodoStorage(),
    instanceName: 'fileSystem',
  );
  getIt.registerSingleton<UserModeStorage>(CachedUserModeStorage());
  getIt.registerFactory<TodoBloc>(
    () => TodoBloc(todoStorage: getIt.get(instanceName: 'fileSystem')),
  );
  getIt.registerFactory<UserModeBloc>(
    () => UserModeBloc(userModeStorage: getIt.get()),
  );
}

void setupSandboxDeps() {
  getIt.registerSingleton<TodoStorage>(
    CachedTodoStorage(),
    instanceName: 'cached',
  );
}
