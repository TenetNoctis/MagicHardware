import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/bindings/general_bindings.dart';
import 'package:magic_hardware/routes/app_routes.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MagicAppTheme.lightTheme,
      darkTheme: MagicAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      // Show loader while authentication repo decides which screen to show
      home: const Scaffold(
        backgroundColor: MagicColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: MagicColors.white),
        ),
      ),
    );
  }
}
