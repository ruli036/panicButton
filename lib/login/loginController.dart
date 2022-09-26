import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/login/dataObject.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/alerts.dart';

class LoginController extends GetxController{
  TextEditingController username= TextEditingController(text: 'ruli');
  TextEditingController password= TextEditingController(text: 'ruli1234');
  RxBool lihatpass = true.obs;
  final keyform = GlobalKey<FormState>();
  final box = GetStorage();
  bool isLogin = false;
  void lihatpassword(){
    lihatpass.value = !lihatpass.value;
  }
  Login? responLogin;
  loginAdmin()async{
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.LOGIN),
        body: {
          'username'  : username.text,
          'password'  : password.text,
        }
    );
    final hasil = json.decode(respon.body);
    responLogin =Login.fromJson(hasil);
    if(responLogin!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responLogin!.meta.message, ()=>Get.back());
    }else{
      box.write('id_user', responLogin!.data.idUser);
      box.write('username', responLogin!.data.username);
      box.write('nama', responLogin!.data.nama);
      box.write('email', responLogin!.data.email);
      box.write('alamat', responLogin!.data.alamat);
      box.write('tgl_buat', responLogin!.data.tglBuat);
      box.write('tgl_aktif', responLogin!.data.tglAktif);
      box.write('islogin', responLogin!.meta.status);
      Get.toNamed('/profile');
    }
  }
  void validasi(){
    final form = keyform.currentState;
    if (form!.validate()) {
      print(username.text);
      loginAdmin();
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLogin = box.read('islogin')??false;
  }
}