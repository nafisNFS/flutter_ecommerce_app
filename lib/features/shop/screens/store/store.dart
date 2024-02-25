

import 'package:flutter/material.dart';

import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const SizedBox(height: TSizes.spaceBtwItems,),
                    //TSearchContainer(text: '',showBorder: true,showBackground: false,padding: EdgeInsets.zero),
                    const TSearchContainer(
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
                      return   GestureDetector(
                        onTap: (){},
                        child:  TRoundedContainer(
                          padding: const EdgeInsets.all(TSizes.sm),
                          showBorder: true,
                          backgroundColor: Colors.transparent,
                          child: Row(
                            children: [
                              ///Icon
                              Flexible(
                                  child: TCircularImage(
                                    isNetworkImage: false,
                                    image: TImages.clothIcon,
                                    backgroundColor: Colors.transparent,
                                    overlayColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
                                  ),
                              ),

                              const SizedBox(width: TSizes.spaceBtwItems / 2,),
                              ///Text
                              Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TBrandTitleWithVerifiedIcon(title: 'Nike',brandTextSize: TextSizes.large,),
                                      Text(
                                        '256 products',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                    ],
                                  )
                              )

                            ],
                          ),
                        ),
                      );


                    })
                  ],
                ),

              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}

