import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/feedback/objectFeedBack.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/alerts.dart';
import 'package:panicbutton/widgets/responCrud.dart';
class FeedBackController extends GetxController{
  ResponFeedBack? responFeedBack;
  ResponCrud? responCrud;
  TextEditingController keterangan = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nama = TextEditingController();
  final keyform = GlobalKey<FormState>();
  RxInt user =0.obs;
  dataFeedBack()async{
    final respon = await http.get(Uri.parse(UrlApi.DATA_FEEDBACK));
    final hasil = json.decode(respon.body);
    List data = hasil['data']??[];
    data.forEach((element) {
      user.value += 2;
    });
    if(data.isEmpty ){
      user.value = 1;
    }
    print(user.value.toString());
    responFeedBack = ResponFeedBack.fromJson(hasil);
  }
  addFeedBack()async{
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.TAMBAH_FEEDBACK),
        body: {
          'nama'          : nama.text,
          'email'         : email.text,
          'keterangan'    : keterangan.text,
        }
    );
    final hasil = json.decode(respon.body);
    responCrud = ResponCrud.fromJson(hasil);
    if(responCrud!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }else{
      nama.text = '';
      email.text = '';
      keterangan.text = '';
      Get.back();
      Get.back();
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }
  }
  Future<Null>refreshData() async{
    await Future.delayed(Duration(seconds: 2));
    dataFeedBack();
  }
  void validasiadd(){
    final form = keyform.currentState;
    if (form!.validate()) {
      addFeedBack();
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataFeedBack();
  }
}