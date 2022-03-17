enum UserMode { normal, sandbox, superSandbox }

abstract class UserModeStorage {
  UserMode? get currentUserMode;
  set currentUserMode(UserMode? currentUserMode);
}

class CachedUserModeStorage extends UserModeStorage {
  UserMode? _currentUserMode = UserMode.normal;

  @override
  UserMode? get currentUserMode => _currentUserMode;

  @override
  set currentUserMode(UserMode? currentUserMode) {
    _currentUserMode = currentUserMode;
  }
}
