import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String userName;

  LoginEvent({required this.userName});

  @override
  List<Object> get props => [userName];
}

class LogoutEvent extends AuthEvent {}
