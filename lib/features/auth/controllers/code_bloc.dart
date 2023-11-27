import 'package:flutter_bloc/flutter_bloc.dart';

class CodeCubit extends Cubit<String> {
  CodeCubit() : super("977");

  void setCode(String code) {
    emit(code);
  }
}
