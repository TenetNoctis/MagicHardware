import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(title: Text('Welding'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              MagicRoundedImage(
                imageUrl: MagicImages.promoBanner2,
                width: double.infinity,
                applyImageRadius: true,
              ),
              SizedBox(height: MagicSizes.spaceBtwSections),

              // Sub-Categories
              Column(
                children: [
                  // Heading
                  MagicSectionHeading(
                    title: 'Welding Gloves',
                    onPressed: () {},
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: MagicSizes.spaceBtwItems),
                      itemBuilder: (context, index) => const MagicProductCardHorizontal(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
