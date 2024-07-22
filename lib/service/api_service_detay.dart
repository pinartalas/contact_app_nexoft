import 'package:contact_app/models/userModel.dart';
import 'package:contact_app/service/api_service_get.dart';
import 'package:dio/dio.dart';

class ApiServiceDetay {
  final Dio _dio = Dio();

  Future<User> fetchUserDetails(String id) async {
    final response = await _dio.get(
      'http://146.59.52.68:11235/api/User/$id',
      options: Options(
        headers: {
          'ApiKey': '3531c4e0-57f0-4b08-a875-c74c28ae2680',
        },
      ),
    );

    if (response.data['success']) {
      return User.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to load user details');
    }
  }

  Future<void> updateUserDetails(String userId, User updatedUser) async {
    final url = 'http://146.59.52.68:11235/api/User/$userId';
    await _dio.put(
      url,
      data: updatedUser.toJson(),
      options: Options(
        headers: {
          'ApiKey': '3531c4e0-57f0-4b08-a875-c74c28ae2680',
        },
      ),
    );
  }

  Future<void> deleteUserDetails(String userId) async {
    final url = 'http://146.59.52.68:11235/api/User/$userId';
    await _dio.delete(
      url,
      options: Options(
        headers: {
          'ApiKey': '3531c4e0-57f0-4b08-a875-c74c28ae2680',
        },
      ),
    );
  }
}
