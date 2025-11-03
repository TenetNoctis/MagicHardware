import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/onboarding.dart';
import 'package:magic_hardware/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MagicAppTheme.lightTheme,
      darkTheme: MagicAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}