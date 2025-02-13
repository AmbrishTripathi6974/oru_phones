import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// EVENTS
abstract class ConfirmNameEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitNameEvent extends ConfirmNameEvent {
  final String name;

  SubmitNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

// STATES
abstract class ConfirmNameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConfirmNameInitial extends ConfirmNameState {}

class ConfirmNameLoading extends ConfirmNameState {}

class ConfirmNameSuccess extends ConfirmNameState {
  final String name;

  ConfirmNameSuccess(this.name);

  @override
  List<Object?> get props => [name];
}

class ConfirmNameFailure extends ConfirmNameState {
  final String error;

  ConfirmNameFailure(this.error);

  @override
  List<Object?> get props => [error];
}

// BLOC CLASS
class ConfirmNameBloc extends Bloc<ConfirmNameEvent, ConfirmNameState> {
  ConfirmNameBloc() : super(ConfirmNameInitial()) {
    on<SubmitNameEvent>((event, emit) async {
      emit(ConfirmNameLoading());

      await Future.delayed(const Duration(seconds: 2)); // Simulating API Call

      if (event.name.length > 2) {
        emit(ConfirmNameSuccess(event.name));
      } else {
        emit(ConfirmNameFailure("Name must be at least 3 characters"));
      }
    });
  }
}
