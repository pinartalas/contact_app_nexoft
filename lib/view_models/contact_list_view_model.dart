import 'package:contact_app/models/userModel.dart';
import 'package:contact_app/service/api_service_get.dart';
import 'package:flutter/foundation.dart';

class ContactListViewModel extends ChangeNotifier {
  List<User> _contacts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get contacts => _contacts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadContacts(String search, int skip, int take) async {
    _isLoading = true;
    notifyListeners();

    try {
      _contacts = await fetchContacts(search, skip, take);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _contacts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
