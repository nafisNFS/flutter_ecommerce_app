import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TTermsAndCondionCheckbox extends StatelessWidget {
  const TTermsAndCondionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Add this line to align text to the top
      children: [
        SizedBox(
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Flexible( // Use Flexible to allow text to wrap if it's too long
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: '${TTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${TTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
              ),
              TextSpan(
                  text: '${TTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: TTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
