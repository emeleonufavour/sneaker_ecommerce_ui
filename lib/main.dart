import 'package:flutter/material.dart';
import 'package:shoe_ecommerce_mobile/app/app.dart';
import 'package:shoe_ecommerce_mobile/ui/view/onboarding/onboarding_screen.dart';

import 'ui/view/home/home.dart';

void main() async {
  await App.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
