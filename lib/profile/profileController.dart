import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:panicbutton/admin/objectAdmin.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/profile/profileObject.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/alerts.dart';
class ProfileController extends GetxController{
  final box = GetStorage();
  final keyform = GlobalKey<FormState>();
  TextEditingController gantiPass = TextEditingController();
  TextEditingController infoApp = TextEditingController();
  TextEditingController idApp = TextEditingController();
  TextEditingController emailApp = TextEditingController();
  var nama,email,alamat,tgl_aktif,id_user,tgl_updateApp;
  Admin? adminObject;
  ResponRegisAdmin? responRegisAdmin;
  ResponApp? responApp;
  RxInt user =0.obs;
   dataAdmin()async{
    final respon = await http.get(Uri.parse(UrlApi.DATA_ADMIN));
    final hasil = json.decode(respon.body);
    List data = hasil['data']??[];
    data.forEach((element) {
      user.value += 2;
    });
    if(data.isEmpty ){
      user.value = 1;
    }
    print(user.value.toString());
    adminObject = Admin.fromJson(hasil);
  }
  dataApp()async{
    final respon = await http.get(Uri.parse(UrlApi.APP));
    final hasil = json.decode(respon.body);
    responApp = ResponApp.fromJson(hasil);
    infoApp.text = responApp!.data.info;
    emailApp.text = responApp!.data.email;
    idApp.text = responApp!.data.idApp.toString();
    tgl_updateApp = responApp!.data.tglUpdate;
  }
  gantiPassword()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.GANTI_PASS),
        body: {
          'id_user'   : id_user.toString(),
          'password'  : gantiPass.text,
         }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    responRegisAdmin = ResponRegisAdmin.fromJson(hasil);
    if(responRegisAdmin!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responRegisAdmin!.meta.message, ()=>Get.back());
    }else{
      Get.back();
      gantiPass.text = '';
      AppAlert.getAlert('Info', responRegisAdmin!.meta.message, ()=>Get.back());

    }
  }
  updateApp()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.UPDATE_APP),
        body: {
          'id_app'    : idApp.text,
          'email'     : emailApp.text,
          'info'      : infoApp.text,
         }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    responRegisAdmin = ResponRegisAdmin.fromJson(hasil);
    if(responRegisAdmin!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responRegisAdmin!.meta.message, ()=>Get.back());
    }else{
      Get.back();
      gantiPass.text = '';
      AppAlert.getAlert('Info', responRegisAdmin!.meta.message, ()=>Get.back());
    }
  }
  back(){
    Get.offAllNamed('/home');
  }
  void validasi(){
    final form = keyform.currentState;
    if (form!.validate()) {
      gantiPassword();
    }
  }
  void validasiApp(){
    final form = keyform.currentState;
    if (form!.validate()) {
      updateApp();
    }
  }
  LogOut(){
    box.erase();
    Get.offAllNamed('/login');
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama = box.read('nama');
    email = box.read('email');
    alamat = box.read('alamat');
    tgl_aktif = box.read('tgl_aktif');
    id_user = box.read('id_user');
    dataAdmin();
    dataApp();
   }
}