import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/features/shop/screens/brand/all_brands.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/brand_controller.dart';
import '../brand/brand_product.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final brandController = Get.put(BrandController());
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: TAppBar(
            showBackArrow: true,
            title: Text('Store', style: Theme
                .of(context)
                .textTheme
                .headlineMedium),
            actions: [
              TCartCounterIcon(onPressed: () {},
                  iconColor: dark ? TColors.white : TColors.black)
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
                      expandedHeight: 440,
                      //
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.all(TSizes.defaultSpace),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children:  [
                            ///Search Bar
                            const SizedBox(height: TSizes.spaceBtwItems,),
                            const TSearchContainer(
                              text: 'Search in Store',
                              showBorder: true,
                              showBackground: false,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: TSizes.spaceBtwSections,),

                            ///Featured Brands
                            TSectionHeading(title: 'Featured Brands                     ', onPressed: () => Get.to(const AllBrandsScreen())),
                            const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                            Obx(
                                (){
                                  if(brandController.isLoading.value) return const TBrandsShimmer();
                                  if(brandController.featuredBrands.isEmpty){
                                    return Center(
                                      child: Text('No Data Found!',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                                  }
                                  return TGridLayout(
                                      itemCount: brandController.featuredBrands.length,
                                      mainAxisExtent: 80,
                                      itemBuilder: (_,index){
                                        final brand = brandController.featuredBrands[index];
                                        return  TBrandCard(
                                            showBorder: true,
                                            brand: brand,
                                            onTap: ()=> Get.to(()=>BrandProducts(brand: brand))
                                        );
                                      });
                                },
                            ),
                          ],
                        ),

                      ),
                      ///Tab
                      bottom: const TTabBar(tabs: [
                        Tab(child: Text('Sports')),
                        Tab(child: Text('Furniture')),
                        Tab(child: Text('Electronics')),
                        Tab(child: Text('Clothes')),
                        Tab(child: Text('Cosmitics')),
                      ])
                  ),
                ];
              },
              body: const TabBarView(
                children: [
                  TCategoryTab(),
                  TCategoryTab(),
                  TCategoryTab(),
                  TCategoryTab(),
                  TCategoryTab(),
                ],
              )
          ),
        ),
    );

  }
}

