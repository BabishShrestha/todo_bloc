import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_riverpod/core/helpers/db_helpers.dart';
import 'package:todo_riverpod/core/models/user_model.dart';

class UserCubit extends Cubit<List<User>> {
  UserCubit() : super([]);
  void refresh() async {
    final userList = await DBHelper.getUserList();
    emit(userList.map((e) => User.fromMap(e)).toList());
  }
}
