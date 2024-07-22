import 'dart:io';
import 'package:contact_app/models/userModel.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> uploadImage(File image) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path),
    });

    final response = await _dio.post(
      'http://146.59.52.68:11235/api/User/UploadImage',
      data: formData,
      options: Options(
        headers: {
          'ApiKey': '3531c4e0-57f0-4b08-a875-c74c28ae2680', // API key
        },
      ),
    );

    return response.data;
  }

  Future<void> submitUserData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String profileImageUrl,
  }) async {
    final response = await _dio.post(
      'http://146.59.52.68:11235/api/User',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'profileImageUrl': profileImageUrl,
      },
      options: Options(
        headers: {
          'ApiKey': '3531c4e0-57f0-4b08-a875-c74c28ae2680', // API key
        },
      ),
    );

    if (response.data['success'] != true) {
      throw Exception('Failed to submit user data');
    }
  }
}
