import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersFetched extends UsersEvent {
  final bool isRefresh;
  UsersFetched({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}