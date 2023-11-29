import 'package:flutter_bloc/flutter_bloc.dart';

class CodeCubit extends Cubit<String> {
  CodeCubit() : super("977");

  void setCountryCode(String code) {
    emit(code);
  }
}
