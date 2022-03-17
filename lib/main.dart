import 'package:architecture_bloc_sample/presentation/home_page.dart';
import 'package:architecture_bloc_sample/presentation/sandbox_home_page.dart';
import 'package:architecture_bloc_sample/service_locator.dart';
import 'package:flutter/material.dart';

import 'presentation/super_sandbox_home_page.dart';

void main() {
  setupMainDeps();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '$HomePage',
      routes: {
        '$HomePage': (_) => const HomePage(),
        '$SandboxHomePage': (_) => const SandboxHomePage(),
        '$SuperSandboxHomePage': (_) => const SuperSandboxHomePage(),
      },
    );
  }
}
