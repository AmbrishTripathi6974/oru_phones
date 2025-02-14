import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import 'sidebar_event.dart';
import 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  final AuthBloc authBloc;
  late final StreamSubscription authSubscription;

  SidebarBloc(this.authBloc) : super(SidebarClosed()) {
    // Listen to AuthBloc state changes
    authSubscription = authBloc.stream.listen((authState) {
      if (authState is AuthenticatedState) {
        add(UserLogin(name: authState.userName, joiningDate: authState.joiningDate));
      } else if (authState is UnauthenticatedState) {
        add(UserLogout());
      }
    });

    on<ToggleSidebar>((event, emit) {
      if (state is SidebarClosed) {
        emit(SidebarOpened());
      } else {
        emit(SidebarClosed());
      }
    });

    on<UserLogin>((event, emit) {
      emit(UserLoggedIn(name: event.name, joiningDate: event.joiningDate));
    });

    on<UserLogout>((event, emit) {
      emit(SidebarClosed()); // Ensure sidebar resets on logout
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
