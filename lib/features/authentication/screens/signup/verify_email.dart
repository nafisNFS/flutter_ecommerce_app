import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../login/login.dart';

class verifyEmailScreen extends StatelessWidget{
  const verifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          //always start from right side
          IconButton(onPressed: () => Get.offAll(()=>const LoginScreen()), icon:const Icon(CupertinoIcons.clear))
        ],
      ),
      body:  SingleChildScrollView(
        //padding to give default equal space on all sides in all screens
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Image
                Image(image: AssetImage(TImages.deliveredEmailIllustration),width: THelperFunctions.screenWidth() * 0.6,),
                const SizedBox(height: TSizes.spaceBtwSections),

                ///Title & SubTitle
                Text(TTexts.confirmEmail,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text('support@codingwitht.com',style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(TTexts.confirmEmailSubTitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwSections),

                ///Buttons
                SizedBox(width: double.infinity,child:ElevatedButton(
                  onPressed: () => Get.to(()=> SuccessScreen(
                      image: TImages.staticSuccessIllustration,
                      title: TTexts.yourAccountCreatedTitle,
                      subTitle: TTexts.yourAccountCreatedSubTitle,
                      onPressed: () => Get.to(() => const LoginScreen()),
                  ),),
                  child: Text(TTexts.tContinue),),),
                const SizedBox(height: TSizes.spaceBtwItems),
                SizedBox(width: double.infinity,child:TextButton(onPressed: (){},child: Text(TTexts.resendEmail),),),
              ],
            ),
        )
      ),
    );
  }

}