

import 'package:flutter/material.dart';

import 'package:t_store/common/widgets/appbar/appbar.dart';

import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_tab.dart';


import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brand/T_brand_card.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: TAppBar(
            showBackArrow: false,
            title: Text('Store', style: Theme
                .of(context)
                .textTheme
                .headlineMedium),
            actions: [
              TCartCounterIcon(onPressed: () {},
                  iconColor: TColors.white)
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

                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:  [
                        ///Search Bar
                        SizedBox(height: TSizes.spaceBtwItems,),
                        //TSearchContainer(text: '',showBorder: true,showBackground: false,padding: EdgeInsets.zero),
                        TSearchContainer(
                          text: 'Search in Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(height: TSizes.spaceBtwSections,),

                        ///Featured Brands
                        TSectionHeading(title: 'Featured Brands                     ', onPressed: () {}),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        TGridLayout(itemCount: 4, mainAxisExtent: 80,itemBuilder: (_,index){
                          return const TBrandCard(
                            showBorder: true,
                          );


                        })
                      ],
                    ),

                  ),
                  ///Tabs
                  bottom: const TTabBar(tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Furniture')),
                    Tab(child: Text('Electronics')),
                    Tab(child: Text('Clothes')),
                    Tab(child: Text('Cosmetics'))
                  ]),
                ),
              ];
            },
            body:  const TabBarView(
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

