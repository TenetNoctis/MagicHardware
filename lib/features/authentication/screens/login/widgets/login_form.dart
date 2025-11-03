import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/authentication/screens/signup/signup.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class MagicLoginForm extends StatelessWidget {
  const MagicLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: MagicSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            // Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: MagicTexts.email,
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwInputFields),

            // Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: MagicTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              obscureText: true,
            ),
            const SizedBox(height: MagicSizes.spaceBtwInputFields / 2),

            // Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(MagicTexts.rememberMe),
                  ],
                ),
                // Forget Password
                TextButton(
                  onPressed: () {},
                  child: const Text(MagicTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(MagicTexts.signIn),
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwItems),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
                child: const Text(MagicTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
