import 'package:flutter/material.dart';
import 'package:magic_hardware/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:magic_hardware/features/shop/screens/home/widgets/home_categories.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MagicPrimaryHeaderContainer(
              child: Column(
                children: [
                  //Appbar
                  MagicHomeAppBar(),
                  SizedBox(height: MagicSizes.spaceBtwSections),

                  // Searchbar
                  MagicSearchContainer(text: 'Search in Store'),
                  SizedBox(height: MagicSizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: EdgeInsets.only(left: MagicSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        MagicSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: MagicColors.white,
                        ),
                        SizedBox(height: MagicSizes.spaceBtwItems),

                        // Categories
                        MagicHomeCategories(),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

