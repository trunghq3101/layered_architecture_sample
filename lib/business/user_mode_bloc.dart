import 'package:architecture_bloc_sample/data/user_mode_storage.dart';

final userModeBloc = UserModeBloc(userModeStorage: userModeStorage);

class UserModeBloc {
  final UserModeStorage _userModeStorage;

  UserModeBloc({required UserModeStorage userModeStorage})
      : _userModeStorage = userModeStorage;

  void changeUserMode(UserMode? userMode) {
    _userModeStorage.currentUserMode = userMode;
  }
}
