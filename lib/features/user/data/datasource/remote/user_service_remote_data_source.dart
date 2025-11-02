

import 'package:user_app_for_sokrio/core/app_config/ulrs.dart';
import 'package:user_app_for_sokrio/core/services/api_service.dart';
import 'package:user_app_for_sokrio/features/user/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers(int page, int perPage);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService apiService;
  UserRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<UserModel>> getUsers(int page, int perPage) async {
    final response = await apiService.getRequest('${AppUrls.baseUrl}/users', params: {
      'page': page,
      'per_page': perPage,
    });
    final data = (response.data['data'] as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
    return data;
  }
}