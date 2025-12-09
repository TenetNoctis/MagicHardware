import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/screens/login/widgets/login_form.dart';
import 'package:magic_hardware/features/authentication/screens/login/widgets/login_header.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';

/// A screen that allows users to log in to their account.
class LoginScreen extends StatelessWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MagicSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, Title & SubTitle
              MagicLoginHeader(dark: dark),

              // Form
              const MagicLoginForm(),

              // Divider
              MagicFormDivider(
                dividerText: MagicTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Footer
              const MagicSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
