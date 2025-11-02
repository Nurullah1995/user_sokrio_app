

import 'package:get_it/get_it.dart';

import 'core/services/api_service.dart';
import 'features/user/data/datasource/remote/user_service_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecase/user_usercase.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton<ApiService>(() => ApiService.instance);

  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetUsersUseCase>(
        () => GetUsersUseCase(sl()),
  );

  sl.registerFactory<UsersBloc>(
        () => UsersBloc(getUsers: sl()),
  );
}