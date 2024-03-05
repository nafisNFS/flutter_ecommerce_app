import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/brand/brand_show_case.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../controllers/product/product_controller.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const TBrandShowCase(images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1
                ]),
                const TBrandShowCase(images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1
                ]),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSectionHeading(
                  title: 'You Might Like',
                  showActionButton: true,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TGridLayout(
                    itemCount: controller.allProducts.length,
                    itemBuilder: (_, index) => TProductCardVertical(product: controller.allProducts[index])),
              ],
            ),
          ),
        ]);
  }
}