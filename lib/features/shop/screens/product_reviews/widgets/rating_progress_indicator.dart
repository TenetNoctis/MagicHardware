import 'package:flutter/material.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/widgets/progress_indicator_and%20rating.dart';

class MagicOverallProductRating extends StatelessWidget {
  const MagicOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge,)),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              MagicRatingProgressIndicator(text: '5', value: 1.0,),
              MagicRatingProgressIndicator(text: '4', value: 0.8,),
              MagicRatingProgressIndicator(text: '3', value: 0.6,),
              MagicRatingProgressIndicator(text: '2', value: 0.4,),
              MagicRatingProgressIndicator(text: '1', value: 0.2,),
            ],
          ),
        ),
      ],
    );
  }
}

