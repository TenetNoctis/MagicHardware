import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
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
                image: AssetImage(MagicHelperFunctions.isDarkMode(context) ? MagicImages.darkAppLogo : MagicImages.lightAppLogo),
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
                'noctis.eden@gmail.com',
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
                  onPressed: () => Get.offAll(
                    () => SuccessScreen(
                      image: MagicHelperFunctions.isDarkMode(context) ? MagicImages.darkAppLogo : MagicImages.lightAppLogo,
                      title: MagicTexts.yourAccountCreatedTitle,
                      subTitle: MagicTexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                    ),
                  ),
                  child: const Text(MagicTexts.mContinue),
                ),
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Resend Email
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
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
