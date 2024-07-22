import 'package:contact_app/components/colors.dart';
import 'package:contact_app/utils/routes/routes_name.dart';
import 'package:contact_app/view/contact_item.dart';
import 'package:contact_app/view_models/contact_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<ContactListViewModel>(context, listen: false);
      viewModel.loadContacts('', 0, 10); // Adjust parameters as needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            title: const Text(
              'Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.newContact);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.blueColor,
                ),
              ),
            ],
          ),
          body: viewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : viewModel.errorMessage.isNotEmpty
                  ? Center(child: Text('Error: ${viewModel.errorMessage}'))
                  : viewModel.contacts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.person,
                                  size: 60, color: AppColors.greyColor),
                              const Text("No Contacts",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                              const Text(
                                  "Contacts you've added will appear here.",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.newContact);
                                },
                                child: const Text("Create New Contact",
                                    style:
                                        TextStyle(color: AppColors.blueColor)),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: viewModel.contacts.length,
                          itemBuilder: (context, index) {
                            final contact = viewModel.contacts[index];
                            return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    contact.profileImageUrl.isNotEmpty
                                        ? contact.profileImageUrl
                                        : 'https://via.placeholder.com/150', // Fallback URL
                                  ),
                                ),
                                title: Text(
                                    '${contact.firstName} ${contact.lastName}'),
                                subtitle: Text(contact.phoneNumber),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ContactItemScreen(userId: contact.id),
                                    ),
                                  );
                                });
                          },
                        ),
        );
      },
    );
  }
}
