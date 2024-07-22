import 'package:contact_app/utils/routes/routes..dart';
import 'package:contact_app/utils/routes/routes_name.dart';
import 'package:contact_app/view/contact_list_screen.dart';
import 'package:contact_app/view_models/ad_contact_screen_view_model.dart';
import 'package:contact_app/view_models/contact_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactListViewModel()),
        ChangeNotifierProvider(create: (_) => AddContactScreenViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexoft',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: RoutesName.contact,
      onGenerateRoute: Routes.generateRoute,
      home: const ContactListScreen(),
    );
  }
}
