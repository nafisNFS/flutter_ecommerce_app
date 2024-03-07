import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/data/repositories.authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/order/order.dart';
import '../profile/profile.dart';




class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth= AuthenticationRepository.instance;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  ///User Profile Card
                  TUserProfileTile(onPressed:() => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),
            ///Body
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    const TSectionHeading(title: 'Account Settings', showActionButton:false),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    TSettingsMenuTile(icon: Iconsax.safe_home, title: 'My Addresses', subTitle: 'Set shopping delivery address',onTap: () => Get.to(() => const UserAddressScreen())),
                    TSettingsMenuTile(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Add,remove products and move to checkout',onTap: ()=> Get.to(()=> const CartScreen())),
                    TSettingsMenuTile(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'In-progress and completed orders',onTap: () => Get.to(() => const OrderScreen()),),
                    TSettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account',onTap: (){},),
                    TSettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons',onTap: (){},),
                    TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set any kind of notification message',onTap: (){},),
                    TSettingsMenuTile(icon: Iconsax.security_card, title: 'Account Privacy', subTitle: 'Manage data usage and connected accounts',onTap: (){},),


                    ///Logout Button
                    const SizedBox(height: TSizes.spaceBtwSections,),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(onPressed:  () async => auth.logout(),child: const Text('Logout'),),
                      //child: OutlinedButton(onPressed:  () async {await auth.logout();},child: const Text('Logout'),),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections * 2.5,),
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}


