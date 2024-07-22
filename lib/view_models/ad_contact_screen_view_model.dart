import 'dart:io';
import 'package:contact_app/components/colors.dart';
import 'package:contact_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContactScreenViewModel extends ChangeNotifier {
  File? _image;
  final ApiService _apiService = ApiService();

  File? get image => _image;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  void showPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> uploadImage(File image) async {
    final response = await _apiService.uploadImage(image);
    if (response['success']) {
      return response['data']['imageUrl'];
    } else {
      throw Exception('Image upload failed');
    }
  }

  Future<void> submitUserData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    String imageUrl = '';

    if (_image != null) {
      imageUrl = await uploadImage(_image!);
    }

    await _apiService.submitUserData(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profileImageUrl: imageUrl,
    );
  }
}
