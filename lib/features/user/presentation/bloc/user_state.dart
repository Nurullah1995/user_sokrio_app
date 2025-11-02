

import 'package:equatable/equatable.dart';
import 'package:user_app_for_sokrio/features/user/domain/entities/user_entities.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoadInProgress extends UsersState {}

class UsersLoadSuccess extends UsersState {
  final List<UserEntity> users;
  final bool hasReachedMax;
  UsersLoadSuccess({required this.users, required this.hasReachedMax});
  @override
  List<Object?> get props => [users, hasReachedMax];
}

class UsersLoadFailure extends UsersState {
  final String message;
  UsersLoadFailure(this.message);
  @override
  List<Object?> get props => [message];
}