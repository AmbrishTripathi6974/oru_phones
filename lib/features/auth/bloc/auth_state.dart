
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final String userName;

  Authenticated({required this.userName});

  @override
  List<Object> get props => [userName];
}
