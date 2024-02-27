import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loader/loaders.dart';
import '../../../../data/repositories.authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/models/user_models.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();//saves lots of memory

  ///Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();//Form key for form validation

  ///SIGNUP
 void signup() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information", TImages.docerAnimation);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      //form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Please Accept Privacy Policy',
            message:
            'In Order to create account, you must have to read and accept the Privacy Policy Term of Use');
        return;
      }

      //register user in the firebase authentication & save user data in the firebase
      final user = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      //save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: user.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: username.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      //show success message
      TLoaders.succesSnackBar(
          title: 'Congratulations',
          message: 'Your Account has been created! Verify email and continue.');

      //move to verify email screen
      Get.to(() =>const  VerifyEmailScreen());


    } catch (e) {
      //show some generic error to the user
      TLoaders.errroSnackBar(title: 'Oh Snap', message: e.toString());

    }finally{
      //remove loader
      TFullScreenLoader.stopLoading();

    }
  }
}
