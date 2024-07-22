import 'package:contact_app/models/userModel.dart';
import 'package:dio/dio.dart';

// API base URL
const String baseUrl = 'http://146.59.52.68:11235/api';
const String apiKey = '3531c4e0-57f0-4b08-a875-c74c28ae2680';

// Function to fetch contacts
Future<List<User>> fetchContacts(String search, int skip, int take) async {
  final dio = Dio();
  final response = await dio.get('$baseUrl/User',
      queryParameters: {
        'search': search,
        'skip': skip,
        'take': take,
      },
      options: Options(headers: {'accept': 'text/plain', 'ApiKey': apiKey}));

  if (response.data['success']) {
    final List<dynamic> usersJson = response.data['data']['users'];
    return usersJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load contacts');
  }
}
