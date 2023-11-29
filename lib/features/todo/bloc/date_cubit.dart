import 'package:flutter_bloc/flutter_bloc.dart';

class DateCubit extends Cubit<String> {
  DateCubit() : super("");

  void setDate(String newState) {
    emit(newState);
  }
}

class StartTimeCubit extends Cubit<String> {
  StartTimeCubit() : super("");

  void setStart(String newState) {
    emit(newState);
  }

  List<int> dates(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;
    return [days, hours, minutes, seconds];
  }
}

class FinishTimeCubit extends Cubit<String> {
  FinishTimeCubit() : super("");

  void setFinish(String newState) {
    emit(newState);
  }
}
