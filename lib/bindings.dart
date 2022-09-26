import 'package:get/get.dart';
import 'package:panicbutton/admin/adminController.dart';
import 'package:panicbutton/call_center/callCenterCotroller.dart';
import 'package:panicbutton/feedback/feedBackController.dart';
import 'package:panicbutton/home/homeCotroller.dart';
import 'package:panicbutton/layanan/layananController.dart';
import 'package:panicbutton/layananTerdekat/terdekatController.dart';
import 'package:panicbutton/login/loginController.dart';
import 'package:panicbutton/profile/profileController.dart';
import 'package:panicbutton/sektor/sektorController.dart';

class UmumBindigs extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeCotroller());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => CallCenterController());
    Get.lazyPut(() => SektorController());
    Get.lazyPut(() => FeedBackController());
    Get.lazyPut(() => LayananController());
    Get.lazyPut(() => LayananTerdekatController());
  }

}