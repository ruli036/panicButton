import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/call_center/objectCallCenter.dart';
import 'package:panicbutton/profile/profileObject.dart';
import 'package:panicbutton/server/api.dart';

class HomeCotroller extends GetxController{
  final box = GetStorage();
  ResponApp? responApp;
  String infoApp= '';
  dataApp()async{
    final respon = await http.get(Uri.parse(UrlApi.APP));
    final hasil = json.decode(respon.body);
    print(hasil);
    responApp = ResponApp.fromJson(hasil);
    infoApp = responApp!.data.info;
    dataCallCenter();
  }
  ResponCallCenter? responCallCenter;
  RxInt user = 0.obs;
  dataCallCenter()async{
    final respon = await http.get(Uri.parse(UrlApi.DATA_CALL_CENTER));
    final hasil = json.decode(respon.body);
    List data = hasil['data']??[];
    data.forEach((element) {
      user.value += 2;
    });
    if(data.isEmpty ){
      user.value = 1;
    }

    responCallCenter = ResponCallCenter.fromJson(hasil);
  }
  Future<Null>refreshData() async{
    await Future.delayed(Duration(seconds: 2));
    dataApp();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataApp();
  }
}