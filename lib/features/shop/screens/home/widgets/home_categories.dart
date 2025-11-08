import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/screens/sub_category/sub_categories.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';


class MagicHomeCategories extends StatelessWidget {
  const MagicHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 9,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return MagicVerticalImageText(
            image: MagicImages.weldingIcon,
            title: 'Welding',
            onTap: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}

