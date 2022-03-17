import 'package:architecture_bloc_sample/business/sandbox_todo_bloc.dart';
import 'package:architecture_bloc_sample/business/super_sandbox_todo_bloc.dart';
import 'package:architecture_bloc_sample/business/todo_bloc.dart';
import 'package:architecture_bloc_sample/business/todo_list_version_bloc.dart';
import 'package:architecture_bloc_sample/business/user_mode_bloc.dart';
import 'package:architecture_bloc_sample/data/todo_list_version_storage.dart';
import 'package:architecture_bloc_sample/data/todo_storage.dart';
import 'package:architecture_bloc_sample/data/user_mode_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

const kFileSystem = 'fileSystem';
const kCached = 'cached';

void setupMainDeps() {
  getIt.registerSingleton<TodoStorage>(
    FileSystemTodoStorage(),
    instanceName: kFileSystem,
  );
  getIt.registerSingleton<UserModeStorage>(CachedUserModeStorage());
  getIt.registerFactory<TodoBloc>(
    () => TodoBloc(todoStorage: getIt.get(instanceName: kFileSystem)),
  );
  getIt.registerFactory<UserModeBloc>(
    () => UserModeBloc(userModeStorage: getIt.get()),
  );
}

void setupSandboxDeps() {
  getIt.registerSingleton<TodoStorage>(
    CachedTodoStorage(),
    instanceName: kCached,
  );
  getIt.registerFactory(
    () => SandboxTodoBloc(
      sandboxTodoStorage: getIt.get(instanceName: kCached),
      normalTodoStorage: getIt.get(instanceName: kFileSystem),
    ),
  );
}

void setupSuperSandboxDeps() {
  getIt.registerSingleton<TodoStorage>(
    CachedTodoStorage(),
    instanceName: kCached,
  );
  getIt.registerSingleton<TodoListVersionStorage>(
    FileSystemTodoListVersionStorage(),
    instanceName: kFileSystem,
  );
  getIt.registerFactory(
    () => SuperSandboxTodoBloc(
      superSandboxTodoStorage: getIt.get(instanceName: kCached),
      normalTodoStorage: getIt.get(instanceName: kFileSystem),
      todoListVersionStorage: getIt.get(instanceName: kFileSystem),
    ),
  );
  getIt.registerFactory(
    () => TodoListVersionBloc(
      todoStorage: getIt.get(instanceName: kCached),
    ),
  );
}
