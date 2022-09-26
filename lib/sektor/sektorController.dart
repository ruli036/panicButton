import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panicbutton/sektor/objectSektor.dart';
import 'package:panicbutton/server/api.dart';
import 'package:http/http.dart' as http;
import 'package:panicbutton/widgets/alerts.dart';
import 'package:panicbutton/widgets/helpers.dart';
import 'package:panicbutton/widgets/responCrud.dart';
import 'package:url_launcher/url_launcher.dart';

class SektorController extends GetxController with GetSingleTickerProviderStateMixin {
  final keyform = GlobalKey<FormState>();
  TextEditingController namaSektor = TextEditingController();
  TextEditingController alamatSektor = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController langth = TextEditingController();
  TextEditingController longth = TextEditingController();
  var id_sektor,id_call;
  ResponCrud? responCrud;
  ResponSektor? responSektor;
  RxInt user = 0.obs;
  GoogleMapController? googleMapController;
  CameraPosition initialCameraPosition = CameraPosition(target: LatLng(5.551694360956613, 95.31766511499882), zoom: 14);
  RxInt cek = 0.obs;
  List<Marker> myMarker = [];
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
  myLocation()async{
    Position position = await _determinePosition();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
    myMarker.clear();
    myMarker.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
    cek +=1;
  }
  onMapTap(LatLng poinTap){
    print(poinTap.toString());
    myMarker = [];
    myMarker.add(
      Marker(
          markerId: MarkerId(poinTap.toString()),
          position: poinTap,
      )
    );
    longth.text = poinTap.longitude.toString();
    langth.text = poinTap.latitude.toString();
    cek +=1;
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
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
  addSektor()async{
    Get.back();
    print("id call"+id_call.toString());
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.TAMBAH_SEKTOR),
        body: {
          'id_call'         : id_call.toString(),
          'nama_sektor'     : namaSektor.text,
          'alamat_sektor'   : alamatSektor.text,
          'no_telp'         : no_telp.text,
          'latlng'          : langth.text,
          'lotlng'          : longth.text,
        }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    responCrud = ResponCrud.fromJson(hasil);
    if(responCrud!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }else{
      Get.back();
      no_telp.text = '';
      namaSektor.text = '';
      alamatSektor.text = '';
      langth.text = '';
      longth.text = '';
      myMarker.clear();
      dataSektor(id_call);
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }
  }
  editSektor()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.EDIT_SEKTOR),
        body: {
          'id_sektor'       : id_sektor.toString(),
          'nama_sektor'     : namaSektor.text,
          'alamat_sektor'   : alamatSektor.text,
          'no_telp'         : no_telp.text,
          'latlng'          : langth.text,
          'lotlng'          : longth.text,
        }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    responCrud = ResponCrud.fromJson(hasil);
    if(responCrud!.meta.status == false){
      Get.back();
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }else{
      Get.back();
      dataSektor(id_call);
      AppAlert.getAlert('Info', responCrud!.meta.message, ()=>Get.back());
    }
  }
  hapusSektor()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.DELETE_SEKTOR),
        body: {
          'id_sektor'  : id_sektor.toString(),
        }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    if(hasil['meta']['status'] == false){
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }else{
      Get.back();
      dataSektor(id_call);
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }
  }
  void validasiadd(){
    final form = keyform.currentState;
    if (form!.validate()) {
      addSektor();
    }
  }
  void validasiedit(){
    final form = keyform.currentState;
    if (form!.validate()) {
        editSektor();
    }
  }
  void pilihAction(String choice){
    if(choice == TombolAdmin.edit){
      var lokasiLama = '${langth.text}, ${longth.text}';
      print("LOKASI LAMA"+ lokasiLama.toString());
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(double.parse(langth.text), double.parse(longth.text)),zoom: 14)));
      myMarker.clear();
      myMarker.add(
          Marker(
            markerId: MarkerId(lokasiLama.toString()),
            position: LatLng(double.parse(langth.text), double.parse(longth.text)),
          )
      );
      cek +=1;
      Get.toNamed('/editSektor');
    }else if(choice == TombolAdmin.Hapus){
      AppAlert.getAlertHapus(id_sektor.toString(),'Warning', "Hapus Data Sektor Ini!", ()=>hapusSektor());
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    dataSektor(id_call);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<Offset>(end: Offset(0, 2), begin: Offset(0, 0))
        .animate(animationController);
  }
}