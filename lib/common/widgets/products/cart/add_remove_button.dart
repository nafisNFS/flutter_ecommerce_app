import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback ? add,remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          size: TSizes.md,
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
          width: 32,
          height: 32,
          color: THelperFunctions.isDarkMode(context)
              ? TColors.white
              : TColors.black,
          onPressed: remove,

        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
         TCircularIcon(
           icon: Iconsax.add,
           backgroundColor: TColors.primary,
           width: 32,
           height: 32,
           size: TSizes.md,
           color: TColors.white,
           onPressed: add,
        ),
      ],
    );
  }
}