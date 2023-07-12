import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/helpers/db_helpers.dart';

import '../../../core/models/user_model.dart';

final userProvider = Provider(
  (ref) => UserState(),
);

class UserState extends StateNotifier<List<User>> {
  UserState() : super([]);
  void refresh() async {
    final userList = await DBHelper.getUserList();
    state = userList.map((e) => User.fromMap(e)).toList();
  }
}
