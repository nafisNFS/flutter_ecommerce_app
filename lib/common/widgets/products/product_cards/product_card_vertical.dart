import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product_details/product_detail.dart';
import 'package:t_store/utils/constants/enums.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadow_styles.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_text_with_verified_icon.dart';


class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            //thumbnail,wishlist button and discount tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  //thumbnail image
                  TRoundedImage(
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                  //sale tag
                  Positioned(
                    top: 12,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.sm),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
                      ),
                    ),
                  ),

                  //fav icon button
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2),
            //details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name
                    TProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    //brand name
                    TBrandTitleWithVerifiedIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [



                        Flexible(
                          child: Column(
                            children: [
                              if (product.productType == ProductType.single.toString() && product.salePrice > 0)
                                Padding(
                                  padding: const EdgeInsets.only(left: TSizes.sm),
                                  child: Text(
                                    product.price.toString(),
                                    style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                                  ),
                                ),

                              /// Price, Show sale price as main price if sale exist.
                              Padding(
                                padding: const EdgeInsets.only(left: TSizes.sm),
                                child: TProductPriceText(price: controller.getProductPrice(product)),
                              ),
                            ],
                          ),
                        ),

                        // add to cart button
                        Container(
                          decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight: Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(child: Icon(Iconsax.add, color: TColors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}

