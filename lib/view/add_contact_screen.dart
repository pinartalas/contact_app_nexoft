import 'dart:io';

import 'package:contact_app/components/colors.dart';
import 'package:contact_app/components/textField.dart';
import 'package:contact_app/utils/routes/routes_name.dart';
import 'package:contact_app/view_models/ad_contact_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddContactScreenViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.greyColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

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
                      child: SingleChildScrollView(
                        child: Card(
                            color: AppColors.whiteColor,
                            elevation:
                                8.0, // Adjust elevation to increase shadow
                            child: SizedBox(
                              width: screenWidth,
                              height: screenHeight - 90.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
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
                                        const Text("New Contact",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        TextButton(
                                          child: const Text(
                                            "Done",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          onPressed: () async {
                                            final viewModel = Provider.of<
                                                    AddContactScreenViewModel>(
                                                context,
                                                listen: false);

                                            await viewModel.submitUserData(
                                              firstName:
                                                  _firstNameController.text,
                                              lastName:
                                                  _lastNameController.text,
                                              phoneNumber:
                                                  _phoneNumberController.text,
                                            );
                                            Navigator.pushNamed(
                                                context, RoutesName.contact);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Consumer<AddContactScreenViewModel>(
                                      builder: (context, viewModel, child) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                viewModel.showPicker(context);
                                              },
                                              child: viewModel.image == null
                                                  ? Icon(
                                                      Icons.person,
                                                      color:
                                                          AppColors.greyColor,
                                                      size: 100,
                                                    )
                                                  : ClipOval(
                                                      child: Image.file(
                                                        viewModel.image!,
                                                        width: 150,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text("Add Photo",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(children: [
                                        textField(
                                          controller: _firstNameController,
                                          label: 'First Name',
                                          hint: "Enter your name",
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        textField(
                                          controller: _lastNameController,
                                          label: 'Last Name',
                                          hint: "Enter your last name",
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        textField(
                                          controller: _phoneNumberController,
                                          label: 'Phone Number',
                                          hint: "Enter your phone number",
                                        ),
                                      ]),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
