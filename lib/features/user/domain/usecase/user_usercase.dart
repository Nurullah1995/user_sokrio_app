import 'package:user_app_for_sokrio/features/user/domain/entities/user_entities.dart';
import 'package:user_app_for_sokrio/features/user/domain/repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository repository;
  GetUsersUseCase(this.repository);

  Future<List<UserEntity>> call({int page = 1, int perPage = 10}) {
    return repository.getUsers(page,perPage);
  }
}