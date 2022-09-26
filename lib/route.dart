import 'package:get/get.dart';
import 'package:panicbutton/bindings.dart';
import 'package:panicbutton/call_center/callCenterView.dart';
import 'package:panicbutton/layanan/layananView.dart';
import 'package:panicbutton/layananTerdekat/layananTerdekatView.dart';
import 'package:panicbutton/profile/profileView.dart';
import 'package:panicbutton/admin/registerView.dart';
import 'package:panicbutton/sektor/formAddSektor.dart';
import 'package:panicbutton/sektor/formEditSektor.dart';
import 'package:panicbutton/sektor/sektorView.dart';
import 'login/loginView.dart';
import 'home/homeView.dart';

final List<GetPage<dynamic>> route = [
  GetPage(name: '/login', page: ()=> const LoginView(),binding: UmumBindigs()),
  GetPage(name: '/home', page: ()=> const HomeView(),binding: UmumBindigs()),
  GetPage(name: '/profile', page: ()=> const ProfilePage(),binding: UmumBindigs()),
  GetPage(name: '/register', page: ()=> const RegisterView(),binding: UmumBindigs()),
  GetPage(name: '/sektor', page: ()=> const SektorView(),binding: UmumBindigs()),
  GetPage(name: '/addSektor', page: ()=> const AddSektorView(),binding: UmumBindigs()),
  GetPage(name: '/editSektor', page: ()=> const EditSektorView(),binding: UmumBindigs()),
  GetPage(name: '/addCallCenter', page: ()=> const AddCallCenter(),binding: UmumBindigs()),
  GetPage(name: '/editCallCenter', page: ()=> const EditCallCenter(),binding: UmumBindigs()),
  GetPage(name: '/layanan', page: ()=> const LayananView(),binding: UmumBindigs()),
  GetPage(name: '/terdekat', page: ()=> const LayananTerdekatView(),binding: UmumBindigs()),
];