import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

/// A screen for verifying the user's email address.
class VerifyEmailScreen extends StatelessWidget {
  /// Creates a [VerifyEmailScreen].
  ///
  /// The [email] parameter is optional and will be displayed on the screen if provided.
  const VerifyEmailScreen({super.key, this.email});

  /// The user's email address.
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                image: AssetImage(
                  MagicHelperFunctions.isDarkMode(context)
                      ? MagicImages.darkAppLogo
                      : MagicImages.lightAppLogo,
                ),
                width: MagicHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Title & Subtitle
              Text(
                MagicTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),
              Text(
                MagicTexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Buttons

              // Continue
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerified(),
                  child: const Text(MagicTexts.mContinue),
                ),
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Resend Email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(MagicTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
