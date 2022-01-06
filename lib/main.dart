import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:technical_test_didinamarudin/moduls/checklistprovider.dart';
import 'package:technical_test_didinamarudin/moduls/cheklist_service.dart';
import 'package:technical_test_didinamarudin/moduls/item_provider.dart';
import 'package:technical_test_didinamarudin/moduls/item_service.dart';
import 'package:technical_test_didinamarudin/screens/home_page.dart';
import 'package:technical_test_didinamarudin/screens/login_page.dart';
import 'package:technical_test_didinamarudin/utils/preference_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token ="";
  init() {
    PreferenceHelper().getToken().then((value) {
      if (value != null) {
        setState(() {
          token = value;
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CheckProvider(
            ChecklistService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemProvider(
            ItemlistService(),
          ),
        ),
      ],
      child: GetMaterialApp(
        title: 'Technical Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:token.isNotEmpty?const HomePage(): const LoginPage(),
      ),
    );
  }
}
