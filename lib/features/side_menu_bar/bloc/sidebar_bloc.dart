import 'package:flutter_bloc/flutter_bloc.dart';

import 'sidebar_event.dart';
import 'sidebar_state.dart';

class SidebarBloc extends Bloc<SidebarEvent, SidebarState> {
  SidebarBloc() : super(SidebarClosed()) {
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
      emit(SidebarOpened());
    });
  }
}
