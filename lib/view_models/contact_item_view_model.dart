import 'package:contact_app/models/userModel.dart';
import 'package:contact_app/service/api_service_detay.dart';
import 'package:contact_app/service/api_service_get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContactItemViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  User? user;
  late final Dio _dio;
  final ApiServiceDetay _apiService = ApiServiceDetay();

  Future<void> fetchUserDetails(String id) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await _apiService.fetchUserDetails(id);
    } catch (e) {
      user = null;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserDetails(String userId, User updatedUser) async {
    isLoading = true;
    notifyListeners();

    try {
      await _apiService.updateUserDetails(userId, updatedUser);
      user = updatedUser;
    } catch (e) {
      errorMessage = 'Failed to update user details';
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteUser(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      await _apiService.deleteUserDetails(userId);
      user = null; // Clear the user information after deletion
    } catch (e) {
      errorMessage = 'Failed to delete user';
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}
