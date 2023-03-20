import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementtwo/provider/countprovider.dart';
import 'package:statemanagementtwo/provider/exampleprovider.dart';
import 'package:statemanagementtwo/screen/count.dart';
import 'package:statemanagementtwo/screen/exampleone.dart';
import 'package:statemanagementtwo/screen/loginscreen.dart';
import 'package:statemanagementtwo/screen/optionscreen.dart';
import 'package:statemanagementtwo/screen/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //ChangeNotifierProvider<CountProvider>(create: (_) => CountProvider(),

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CountProvider>(create: (_) => CountProvider()),
        ChangeNotifierProvider<ExampleProvider>(
            create: (_) => ExampleProvider())
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        },
      ),
    );
  }
}
