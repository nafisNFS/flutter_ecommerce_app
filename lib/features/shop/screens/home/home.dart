
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_store/common/widgets/texts/section_heading.dart';

import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';

import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';


import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      THomeAppBar(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      TSearchContainer(
                        text: 'Search in Store',
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                        child: Column(
                          children: [
                            TSectionHeading(
                              title: 'Popular Categories',
                              showActionButton: false,
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            THomeCategories()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3
                      ],
                    ),
                    TSectionHeading(
                      title: 'Popular Products                   ',
                      showActionButton: true,
                      onPressed: () => Get.to(() => const AllProducts()),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TGridLayout(
                        itemCount: 4,
                        itemBuilder: (_, index) => const TProductCardVertical())
                  ],
                ),
              )
            ],
          )),
    );
  }
}