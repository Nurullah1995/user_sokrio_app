

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app_for_sokrio/features/user/domain/entities/user_entities.dart';
import 'package:user_app_for_sokrio/features/user/domain/usecase/user_usercase.dart';
import 'package:user_app_for_sokrio/features/user/presentation/bloc/user_event.dart';
import 'package:user_app_for_sokrio/features/user/presentation/bloc/user_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsers;
  final int perPage = 10;
  int page = 1;
  bool isFetching = false;
  List<UserEntity> allFetched = [];

  UsersBloc({required this.getUsers}) : super(UsersInitial()) {
    on<UsersFetched>(_onFetched);
  }

  Future<void> _onFetched(UsersFetched event, Emitter<UsersState> emit) async {
    if (isFetching && !event.isRefresh) return;

    try {
      isFetching = true;

      if (event.isRefresh) {
        page = 1;
        allFetched.clear();
        emit(UsersLoadInProgress());
      } else if (state is UsersInitial) {
        emit(UsersLoadInProgress());
      }

      final List<UserEntity> fetched =
      await getUsers(page: page, perPage: perPage);

      final bool reachedEnd = fetched.length < perPage;

      if (event.isRefresh) {
        allFetched = List.from(fetched);
      } else {
        allFetched.addAll(fetched);
      }

      emit(UsersLoadSuccess(
        users: allFetched,
        hasReachedMax: reachedEnd,
      ));

      if (!reachedEnd) page++;
    } catch (e) {
      emit(UsersLoadFailure(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}