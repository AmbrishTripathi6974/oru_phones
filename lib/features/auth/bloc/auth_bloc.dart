import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oru_phones/features/auth/bloc/auth_state.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {
    on<LoginEvent>((event, emit) {
      emit(Authenticated(userName: event.userName));
    });

    on<LogoutEvent>((event, emit) {
      emit(Unauthenticated());
    });
  }
}
