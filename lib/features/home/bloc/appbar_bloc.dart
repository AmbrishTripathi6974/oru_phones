import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AppBarEvent {}

class ScrollUpEvent extends AppBarEvent {}

class ScrollDownEvent extends AppBarEvent {}

// States
abstract class AppBarState {
  final bool isCollapsed;

  AppBarState(this.isCollapsed);
}

class AppBarExpanded extends AppBarState {
  AppBarExpanded() : super(false);
}

class AppBarCollapsed extends AppBarState {
  AppBarCollapsed() : super(true);
}

// Bloc
class AppBarBloc extends Bloc<AppBarEvent, AppBarState> {
  AppBarBloc() : super(AppBarExpanded()) {
    on<ScrollUpEvent>((event, emit) => emit(AppBarCollapsed()));
    on<ScrollDownEvent>((event, emit) => emit(AppBarExpanded()));
  }
}
