
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailCubit extends Cubit<String> {
  EmailCubit() : super("");

  void updateEmail(String email) {
    emit(email);
  }

  void sendEmail() {
    // Currently, this does nothing (void action)
  }
}
