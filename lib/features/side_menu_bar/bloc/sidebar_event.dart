import 'package:equatable/equatable.dart';

abstract class SidebarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleSidebar extends SidebarEvent {}

class UserLogin extends SidebarEvent {
  final String name;
  final String joiningDate;

  UserLogin({required this.name, required this.joiningDate});

  @override
  List<Object> get props => [name, joiningDate];
}

class UserLogout extends SidebarEvent {}
