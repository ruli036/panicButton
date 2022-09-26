import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panicbutton/sektor/objectSektor.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/sektor/sektorController.dart';
import 'package:panicbutton/server/api.dart';
import 'package:url_launcher/url_launcher.dart';

class LayananController extends GetxController with SingleGetTickerProviderMixin{
  var instansi,id_call,no_callCenter,logo_instansi,call_langth,call_longth;
  late Animation<Offset> animation;
  late AnimationController animationController;
  RxInt user = 0.obs;
  ResponSektor? responSektor;
  dataSektor(id)async{
    print("ID "+id.toString());
    final respon = await http.post(Uri.parse(UrlApi.DATA_SEKTOR),
        body: {
          'id_call'  : id.toString(),
        }
    );
    final hasil = json.decode(respon.body);
    List data = hasil['data']??[];
    data.forEach((element) {
      user.value += 2;
    });
    if(data.isEmpty ){
      user.value = 1;
    }
    responSektor = ResponSektor.fromJson(hasil);
  }
  Future<Null>refreshData() async{
    await Future.delayed(Duration(seconds: 2));
    dataSektor(id_call);
  }
  scrool(notification){
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.reverse) {
      animationController.forward();
    } else if (direction == ScrollDirection.forward) {
      animationController.reverse();
    }
    return true;
  }
  Future<void> buatPanggilan(String url) async {
    await launch('tel:$url');
  }
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id_call = GetStorage().read('id_call');
    instansi = GetStorage().read('instansi');
    no_callCenter = GetStorage().read('no_call');
    logo_instansi = GetStorage().read('logo_instansi');
    call_langth = GetStorage().read('call_langth');
    call_longth = GetStorage().read('call_longth');
    dataSektor(id_call);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<Offset>(end: Offset(0, 2), begin: Offset(0, 0))
        .animate(animationController);
  }
}