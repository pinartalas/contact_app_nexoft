import 'package:contact_app/utils/routes/routes_name.dart';
import 'package:contact_app/view/add_contact_screen.dart';
import 'package:contact_app/view/contact_list_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.contact:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactListScreen());
      // case RoutesName.newContact:
      //   return MaterialPageRoute(builder: (BuildContext context)=> const )
      case RoutesName.newContact:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddContactScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
