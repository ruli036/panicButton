import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/admin/adminController.dart';
import 'package:panicbutton/admin/adminView.dart';
import 'package:panicbutton/admin/objectAdmin.dart';
import 'package:panicbutton/profile/profileController.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/alerts.dart';
import 'package:panicbutton/widgets/helpers.dart';
class AdminController extends GetxController with SingleGetTickerProviderMixin{

  final keyform = GlobalKey<FormState>();
  final keyform2 = GlobalKey<FormState>();
  TextEditingController username= TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController editNama = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editAlamat = TextEditingController();
  ResponRegisAdmin? adminObject;
  final box = GetStorage();
  var id_user;
  final getDataAdmin = Get.find<ProfileController>();
  late Animation<Offset> animation;
  late AnimationController animationController;

  scrool(notification){
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.reverse) {
      animationController.forward();
    } else if (direction == ScrollDirection.forward) {
      animationController.reverse();
    }
    return true;
  }
  registerAdmin()async{
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.REGISTER),
        body: {
          'username'  : username.text,
          'nama'      : nama.text,
          'email'     : email.text,
          'alamat'    : alamat.text,
        }
    );
    final hasil = json.decode(respon.body);
    adminObject = ResponRegisAdmin.fromJson(hasil);
    print(hasil);
    if(adminObject!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', adminObject!.meta.message, ()=>Get.back());
    }else{
      nama.text = '';
      email.text = '';
      username.text = '';
      alamat.text = '';
      Get.back();
      Get.back();
      getDataAdmin.dataAdmin();
     }
  }

  editAdmin()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.EDIT_ADMIN),
        body: {
          'id_user'   : id_user.toString(),
          'nama'      : editNama.text,
          'email'     : editEmail.text,
          'alamat'    : editAlamat.text,
        }
    );
    final hasil = json.decode(respon.body);
    adminObject = ResponRegisAdmin.fromJson(hasil);
    if(adminObject!.meta.status == false){
      AppAlert.getAlert('Info', adminObject!.meta.message, ()=>Get.back());
    }else{
      var id_login = box.read('id_user');
      if(id_login.toString() == id_user.toString()){
        box.write('alamat', editAlamat.text);
        box.write('nama', editNama.text);
        box.write('email',  editEmail.text);
      }
      Get.back();
      getDataAdmin.dataAdmin();
      AppAlert.getAlert('Info', adminObject!.meta.message, ()=>Get.back());
     }
  }
  Future<Null>refreshData() async{
    await Future.delayed(Duration(seconds: 2));
    getDataAdmin.dataAdmin();
  }
  hapusAdmin()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.DELETE_ADMIN),
        body: {
          'id_user'  : id_user.toString(),
        }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    if(hasil['meta']['status'] == false){
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }else{
      Get.back();
      getDataAdmin.dataAdmin();
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }
  }
  void pilihAction(String choice){
    if(choice == TombolAdmin.edit){
      Get.defaultDialog(
        title:"Edit Admin",
        textConfirm: "Simpan",
        textCancel: "Batal",
        confirmTextColor: Colors.white,
        content: EditAdminView(),
        onConfirm: ()=>validasi2(),
      );
    }else if(choice == TombolAdmin.Hapus){
      AppAlert.getAlertHapus(id_user.toString(),'Warning', "Yakin Menghapus Admin Ini?", ()=>hapusAdmin());
    }
  }
  void validasi(){
    final form = keyform.currentState;
    if (form!.validate()) {
      registerAdmin();
    }
  }
  void validasi2(){
    final form = keyform2.currentState;
    if (form!.validate()) {
      editAdmin();
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id_user = box.read('id_user');
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<Offset>(end: Offset(0, 2), begin: Offset(0, 0))
        .animate(animationController);
    }

}

