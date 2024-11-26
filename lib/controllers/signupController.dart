import 'package:firebase_connection/Provider/signupProvider.dart';
import 'package:get/get.dart';

class Signupcontroller extends GetxController {
  final obsecure = true.obs;
  final comformPassword = "".obs;
  final isSuccess = false.obs;
  Signupprovider signupprovider = Signupprovider();
  Future<void> signup(signupdata) async {
    print(signupdata);
    isSuccess.value = await signupprovider.signup(signupdata);
  }
}
