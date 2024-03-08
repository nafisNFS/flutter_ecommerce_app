import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';


class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController =CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) =>const  SizedBox(height: TSizes.spaceBtwSections,),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx( ()
          {
            final item=cartController.cartItems[index];
            return Column(
              children: [
                TCartItem(cartItem: item,),
                if(showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems,),

                if(showAddRemoveButton)
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          TProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            add: () =>cartController.addOneToCart(item),
                            remove: () => cartController.removeOneFromCart(item),
                          ),
                        ],
                      ),
                      TProductPriceText(price:(item.price*item.quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            );
          }
        )
      ),
    );
  }
}
