
import 'package:user_app_for_sokrio/features/user/data/datasource/remote/user_service_remote_data_source.dart';
import 'package:user_app_for_sokrio/features/user/data/models/user_model.dart';
import 'package:user_app_for_sokrio/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UserModel>> getUsers(int page, int perPage) {
    return remoteDataSource.getUsers(page, perPage);
  }
}