import 'package:architecture_bloc_sample/data/user_mode_storage.dart';
import 'package:architecture_bloc_sample/service_locator.dart';

class UserModeBloc {
  final UserModeStorage _userModeStorage;

  UserModeBloc({required UserModeStorage userModeStorage})
      : _userModeStorage = userModeStorage;

  bool startUserMode(UserMode? userMode) {
    final currentUserMode = _userModeStorage.currentUserMode;
    if (currentUserMode == userMode) return false;
    getIt.pushNewScope(scopeName: userMode.toString());
    switch (userMode) {
      case UserMode.sandbox:
        setupSandboxDeps();
        break;
      case UserMode.superSandbox:
        setupSuperSandboxDeps();
        break;
      default:
    }
    _userModeStorage.currentUserMode = userMode;
    return true;
  }

  void exitUserMode() {
    getIt.popScope();
    _userModeStorage.currentUserMode = UserMode.normal;
  }
}
