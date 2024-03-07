import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/loader/loaders.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/home/widgets/home_appbar.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true,title: Text('Profile'),),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx((){
                      final networkImage=controller.user.value.profilePicture;
                      final image=networkImage.isNotEmpty ? networkImage : TImages.user;
                      return controller.imageUploading.value
                        ? const TShimmerEffect(width: 80,height: 80,radius: 80,)
                        :  TCircularImage(image: image,width: 80,height: 80,isNetworkImage: networkImage.isNotEmpty,);
                    }),
                    TextButton(onPressed: () => controller.uploadUserProfilePicture(), child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///Details
              const SizedBox(height: TSizes.spaceBtwItems /2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Profile Information' , showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TProfileMenu(title: 'Name',value: controller.user.value.fullName,onPressed: () => Get.to (() => const ChangeName()),),
              TProfileMenu(title: 'Username',value: controller.user.value.username,onPressed: (){},),

              const SizedBox(height: TSizes.spaceBtwItems,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Heading Personal Info
              const TSectionHeading(title: 'Personal Information',showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TProfileMenu(title: 'User ID',value: controller.user.value.id,icon: Iconsax.copy,onPressed: (){}),
              TProfileMenu(title: 'E-mail',value: controller.user.value.email,onPressed: (){},),
              TProfileMenu(title: 'Phone Number',value: controller.user.value.phoneNumber,onPressed: (){},),
              TProfileMenu(title: 'Date of Birth',value: '30 Jan, 2001',onPressed: (){},),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account' , style: TextStyle(color: Colors.red),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName= TextEditingController();
  final lastName= TextEditingController();
  final userController = UserController.instance;
  final userRepository= Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey =GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit(){
    initializeNames();
    super.onInit();
  }

  //Fetch user record
  Future<void> initializeNames() async{
    firstName.text=userController.user.value.firstName;
    lastName.text=userController.user.value.lastName;
  }

  Future<void> updateUserName() async{
   try{
     //start loading
     TFullScreenLoader.openLoadingDialog('We are updating your information', TImages.docerAnimation);

     //Check Internet Connectivity
     final isConnected= await NetworkManager.instance.isConnected();
     if(!isConnected){
       TFullScreenLoader.stopLoading();
       return;
     }

     //Form Validation
     if(!updateUserNameFormKey.currentState!.validate()){
       TFullScreenLoader.stopLoading();
       return;
     }

     //update user's first & last name in the Firebase Firestore
     Map<String, dynamic> name={'FirstName': firstName.text.trim(),'LastName': lastName.text.trim()};
     await userRepository.updateSingleField(name);

     //update the Rx User value
     userController.user.value.firstName=firstName.text.trim();
     userController.user.value.lastName=lastName.text.trim();

     //Remove loader
     TFullScreenLoader.stopLoading();

     //show success message
     TLoaders.successSnackBar(title: 'Congratulations',message: 'Your name has been updates.');

     //Move to previous screen
     Get.off(() => const ProfileScreen());
   }catch(e){
     TFullScreenLoader.stopLoading();
     TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
   }
  }

}



