import 'package:flutter/cupertino.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TShimmerEffect(width: 50, height: 50, radius: 50),
        SizedBox(width: TSizes.spaceBtwItems / 2),
        Column(
          children: [
            TShimmerEffect(width: 100, height: 15),
            SizedBox(width: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: 80, height: 12),
          ],
        )
      ],
    );
  }
}
