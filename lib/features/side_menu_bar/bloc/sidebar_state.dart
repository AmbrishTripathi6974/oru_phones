import 'package:equatable/equatable.dart';

abstract class SidebarState extends Equatable {
  @override
  List<Object> get props => [];
}

class SidebarClosed extends SidebarState {}

class SidebarOpened extends SidebarState {}

class UserLoggedIn extends SidebarState {
  final String name;
  final String joiningDate;

  UserLoggedIn({required this.name, required this.joiningDate});

  @override
  List<Object> get props => [name, joiningDate];
}
