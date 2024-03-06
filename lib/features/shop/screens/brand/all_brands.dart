import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brand/brand_card.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';

import 'package:t_store/utils/constants/sizes.dart';
import '../../../../common/widgets/shimmers/brands_shimmer.dart';
import '../../controllers/product/brand_controller.dart';
import 'brand_product.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(title: Text('Brand')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHeading(title: 'Brands'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(
                    (){
                  if(brandController.isLoading.value) return const TBrandsShimmer();
                  if(brandController.allBrands.isEmpty){
                    return Center(
                        child: Text('No Data Found!',style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
                  }
                  return TGridLayout(
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_,index){
                        final brand = brandController.featuredBrands[index];
                        return  TBrandCard(showBorder: true,
                          brand: brand,
                          onTap: ()=> Get.to(()=>  BrandProducts(brand: brand)),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}