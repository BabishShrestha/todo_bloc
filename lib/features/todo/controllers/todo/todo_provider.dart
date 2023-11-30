// import 'dart:math';

// import 'dart:ui';

// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../../../core/helpers/db_helpers.dart';
// import '../../../../core/models/task_model.dart';
// import '../../../../core/utils/constants.dart';

// part 'todo_provider.g.dart';

// @riverpod
// class TodoState extends _$TodoState {
//   @override
//   List<Task> build() {
//     return [];
//   }

//   void refresh() async {
//     final data = await DBHelper.getItemList();
//     state = data.map((e) {
//       return  Task.fromMap(e);
//     }).toList();
//   }

//   void addItem(Task task) async {
//     await DBHelper.createTask(task);
//     refresh();
//   }

//   void updateItem(Task task) async {
//     await DBHelper.updateItem(task);
//     refresh();
//   }

//   void deleteItem(int id) async {
//     await DBHelper.deleteItem(id);
//     refresh();
//     // state = data.map((e) => Task.fromMap(e)).toList();
//   }

//   void markAsCompleted(Task task) async {
//     await DBHelper.updateItem(task.copyWith(id: task.id ?? 0, isCompleted: 1));
//     refresh();
//     // state = data.map((e) => Task.fromMap(e)).toList();
//   }

// // today
//   String getToday() {
//     DateTime today = DateTime.now();
//     return today.toString().substring(0, 10);
//   }

//   // tomorrow
//   String getTomorrow() {
//     DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
//     return tomorrow.toString().substring(0, 10);
//   }

//   String getDayAfterTomorrow() {
//     DateTime dayAfterTomorrow = DateTime.now().add(const Duration(days: 2));
//     return dayAfterTomorrow.toString().substring(0, 10);
//   }

//   // day after tomorrow
//   List<String> getLast30Days() {
//     DateTime oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
//     List<String> dateList = [];
//     for (int i = 0; dateList.length < 30; i++) {
//       DateTime date = oneMonthAgo.add(Duration(days: i));
//       dateList.add(date.toString().substring(0, 10));
//     }
//     return dateList;
//     // return dayAfterTomorrow.toString().substring(0, 10);
//   }

//   Color getRandomColor() {
//     Random random = Random();
//     int randomIndex = random.nextInt(AppConst.colors.length);
//     Color randomColor = AppConst.colors[randomIndex];
//     return randomColor;
//   }

//   bool getStatus(Task task) {
//     bool? isCompleted;
//     if (task.isCompleted == 0) {
//       isCompleted = false;
//     } else {
//       isCompleted = true;
//     }
//     return isCompleted;
//   }
// }
