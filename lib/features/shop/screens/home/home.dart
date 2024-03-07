
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';

import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';

import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widgets/promo_slider.dart';

import 'package:t_store/utils/constants/sizes.dart';


import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
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
                    const TPromoSlider(),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    TSectionHeading(
                      title: 'Popular Products                   ',
                      showActionButton: true,
                      onPressed: () => Get.to(() => AllProducts(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      )),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Obx((){
                      if(controller.isLoading.value) return const TVerticalProductShimmer();

                      if(controller.featuredProducts.isEmpty) {
                        return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                      }
                      return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]));
                    })
                  ],
                ),
              )
            ],
          )),
    );
  }
}