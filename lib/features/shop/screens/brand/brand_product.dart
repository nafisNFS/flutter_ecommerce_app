import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/brand/brand_card.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/features/shop/controllers/product/brand_controller.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/sortable_product.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return  Scaffold(
      appBar:  TAppBar(
        title: Text(brand.name),
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandCard(showBorder: true, brand: brand),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
                builder: (context, snapshot) {
                  const loader = TVerticalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultipleRecordState(snapshot: snapshot,loader: loader);
                  if(widget!=null)return widget;
                  final brandProducts = snapshot.data!;
                  return TSortableProducts(products: brandProducts);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}