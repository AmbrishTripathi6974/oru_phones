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
    // 🔹 Listen to AuthBloc state changes
    authSubscription = authBloc.stream.listen((authState) {
      if (authState is AuthenticatedState) {
        add(UserLogin(name: authState.userName, joiningDate: authState.joiningDate));
      } else {
        add(UserLogout());
      }
    });

    // 🔹 Sidebar toggle logic
    on<ToggleSidebar>((event, emit) {
      emit(state is SidebarClosed ? SidebarOpened() : SidebarClosed());
    });

    // 🔹 Handle user login (update sidebar state)
    on<UserLogin>((event, emit) {
      emit(UserLoggedIn(name: event.name, joiningDate: event.joiningDate));
    });

    // 🔹 Handle user logout (close sidebar)
    on<UserLogout>((event, emit) {
      emit(SidebarClosed());
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
