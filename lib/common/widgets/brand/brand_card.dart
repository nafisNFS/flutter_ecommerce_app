import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';

import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../custom_shapes/containers/rounded_container.dart';
import '../texts/t_brand_title_text_with_verified_icon.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap, required this.brand,
  });
  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Flexible(
            child: TCircularImage(
              isNetworkImage: true,
              image: brand.image,
              backgroundColor: Colors.transparent,
              overlayColor: isDark ? TColors.white : TColors.black,
            ),
          ),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  TBrandTitleWithVerifiedIcon(
                  title: brand.name,
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  '${brand.productsCount ?? 0} products',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}