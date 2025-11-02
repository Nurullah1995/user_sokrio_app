
import 'package:user_app_for_sokrio/features/user/data/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers(int page, int perPage);
}