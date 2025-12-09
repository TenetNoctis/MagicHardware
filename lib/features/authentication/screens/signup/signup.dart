import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/login_signup/form_divider.dart';
import 'package:magic_hardware/common/widgets/login_signup/social_buttons.dart';
import 'package:magic_hardware/features/authentication/screens/signup/widgets/signup_form.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

/// A screen that allows users to create a new account.
class SignupScreen extends StatelessWidget {
  /// Creates a [SignupScreen].
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                MagicTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              //Form
              const MagicSignupForm(),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Divider
              MagicFormDivider(
                dividerText: MagicTexts.orSignUpWith.capitalize!,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Social Buttons
              const MagicSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
