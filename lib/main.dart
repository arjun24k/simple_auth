import 'package:fintech_asmt/utils/Components/ResponsiveUI.dart';
import 'package:fintech_asmt/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class ScaffoldKey {
  static final scaffoldkey = GlobalKey<ScaffoldMessengerState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ScaffoldKey.scaffoldkey,
      theme: ThemeData(
        fontFamily: 'Jakarta',
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
      ),
      initialRoute: PageRoutes.landingPage,
      routes: PageRoutes.routes(),
    );
  }
}
