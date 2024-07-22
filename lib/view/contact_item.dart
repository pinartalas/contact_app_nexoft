import 'package:contact_app/models/userModel.dart';
import 'package:contact_app/utils/routes/routes_name.dart';
import 'package:contact_app/view_models/contact_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_app/components/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContactItemScreen extends StatelessWidget {
  final String userId;

  const ContactItemScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactItemViewModel()..fetchUserDetails(userId),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Consumer<ContactItemViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = viewModel.user;
            if (user == null) {
              return const Center(child: Text('User not found'));
            }

            return Stack(
              children: [
                Positioned(
                  top: 100.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Card(
                      color: AppColors.whiteColor,
                      elevation: 8.0, // Adjust elevation to increase shadow
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 400,
                          height: 600,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: AppColors.blueColor),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Text("Edit Contact",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    TextButton(
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      onPressed: () async {
                                        User updatedUser = User(
                                          id: user.id,
                                          createdAt: user.createdAt,
                                          firstName: user.firstName,
                                          lastName: user.lastName,
                                          phoneNumber: user.phoneNumber,
                                          profileImageUrl: user.profileImageUrl,
                                        );
                                        await viewModel.updateUserDetails(
                                            userId, updatedUser);
                                        Navigator.pushNamed(
                                            context, RoutesName.contact);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      // Implement image upload and update profileImageUrl
                                      final file = File(pickedFile.path);
                                      // Example: You could upload the file to your server here and get the URL
                                      // final imageUrl = await uploadImage(file);
                                      // For now, let's just set a local file URL
                                      viewModel.user?.profileImageUrl =
                                          file.path;
                                      viewModel.notifyListeners();
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.profileImageUrl),
                                    radius: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: const Text("Change Photo",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    TextField(
                                      onChanged: (value) =>
                                          viewModel.user?.firstName = value,
                                      decoration: InputDecoration(
                                        hintText: user.firstName,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      onChanged: (value) =>
                                          viewModel.user?.lastName = value,
                                      decoration: InputDecoration(
                                        hintText: user.lastName,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      onChanged: (value) =>
                                          viewModel.user?.phoneNumber = value,
                                      decoration: InputDecoration(
                                        hintText: user.phoneNumber,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: TextButton(
                                          child: const Text(
                                            "Delete Account",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red),
                                          ),
                                          onPressed: () async {
                                            bool confirm = await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "Delete Account"),
                                                content: const Text(
                                                    "Are you sure you want to delete your account?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text("Delete"),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (confirm == true) {
                                              await viewModel
                                                  .deleteUser(userId);
                                              if (viewModel.errorMessage ==
                                                  null) {
                                                Navigator.pushNamed(context,
                                                    RoutesName.contact);
                                              } else {
                                                // Show an error message
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(viewModel
                                                        .errorMessage!),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
