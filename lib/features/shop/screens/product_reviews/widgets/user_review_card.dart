import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/products/rating/rating_indicator.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(backgroundImage: AssetImage(TImages.userProfileImage1)),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text('Rifat Doe', style: Theme.of(context).textTheme.titleLarge)
                ],
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          ///Review
          Row(
            children: [
              const TRatingBarIndicator(rating: 4),
              const SizedBox(width: TSizes.spaceBtwItems,),
              Text('26 Feb 2024', style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          const ReadMoreText(
            "The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. The user interface of the app is quite intuitive. I was able to navigate and make purhcase seamlessly. Great",
            trimLines: 1,
            trimMode: TrimMode.Line,
            trimExpandedText: ' show less',
            trimCollapsedText: ' show more',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          ///Company Review
          TRoundedContainer(
            backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("T ' Store", style: Theme.of(context).textTheme.titleMedium),
                      Text('27 Feb 2024', style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const ReadMoreText(
                    "Thanks so much for sharing your experience with us.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' show less',
                    trimCollapsedText: ' show more',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                  )
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}