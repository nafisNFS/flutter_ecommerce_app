import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/popups/animation_loader.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.headlineSmall,
          )),
      body:Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                child:  Obx(() {
                  ///nothing found widget
                  final emptyWidget = TAnimationLoaderWidget(
                    text: 'Whoops!Cart is EMPTY.',
                    animation: TImages.docerAnimation,
                    showAction: true,
                    actionText: 'Let\'s fill it',
                    onActionPressed: () => Get.off(() => const NavigationMenu()),
                  );

                  if (controller.cartItems.isEmpty) {
                    return emptyWidget;
                  } else {
                    return const SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(TSizes.defaultSpace),
                        child: TCartItems(),
                      ),
                    );
                  }
                }),

              )
          )
        ],
      ),



      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() =>
                    Text('Checkout ${controller.totalCartPrice.value} TK')),
              ),
            ),
    );
  }
}
