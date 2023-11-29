// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'date_provider.g.dart';

// @riverpod
// class DateState extends _$DateState {
//   @override
//   String build() {
//     return "";
//   }

//   void setDate(String newState) {
//     state = newState;
//   }
// }

// @riverpod
// class StartTimeState extends _$StartTimeState {
//   @override
//   String build() {
//     return "";
//   }

//   void setStart(String newState) {
//     state = newState;
//   }

//   List<int> dates(DateTime date) {
//     final now = DateTime.now();
//     final difference = date.difference(now);
//     final days = difference.inDays;
//     final hours = difference.inHours % 24;
//     final minutes = difference.inMinutes % 60;
//     final seconds = difference.inSeconds % 60;
//     return [days, hours, minutes, seconds];
//   }
// }

// @riverpod
// class FinishTimeState extends _$FinishTimeState {
//   @override
//   String build() {
//     return "";
//   }

//   void setFinish(String newState) {
//     state = newState;
//   }
// }
