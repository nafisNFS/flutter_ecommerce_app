import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:t_store/common/styles/spacing_styles.dart";
import 'package:t_store/common/widgets.login_signup/form_divider.dart';
import "package:t_store/features/authentication/screens/login/widgets/login_form.dart";
import "package:t_store/features/authentication/screens/login/widgets/login_header.dart";

import "../../../../common/widgets.login_signup/social_buttons.dart";
import "../../../../utils/constants/sizes.dart";
import "../../../../utils/constants/text_strings.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView( //for scrollable
        child: Padding(
            padding:TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
                ///Logo,title,subtitle
                 TLoginHeader(),
                ///Form
                 TLoginForm(),
                ///Divider
                 TFormDivider(dividerText: TTexts.orSignInWith.capitalize!,),
                const SizedBox(height: TSizes.spaceBtwItems),
                ///Footer
                TSocialButtons(),
              ],
            ),
        ),
      ),
    );
  }
}








