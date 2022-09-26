import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panicbutton/sektor/objectSektor.dart';
import 'package:panicbutton/sektor/sektorController.dart';
import 'package:panicbutton/server/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LayananTerdekatController extends GetxController{
 GoogleMapController? googleMapController;
 CameraPosition initialCameraPosition = CameraPosition(target: LatLng(5.551694360956613, 95.31766511499882), zoom: 14);
 Set<Marker> markers = {};
 RxInt user = 0.obs;
 ResponSektor? responSektor;
 final sektorC = Get.find<SektorController>();
 var id_call;
 List<Marker> myMarker = [];
 dataSektor(id)async{
  final respon = await http.post(Uri.parse(UrlApi.DATA_SEKTOR),
      body: {
       'id_call'  : id.toString(),
      }
  );
  final hasil = json.decode(respon.body);
  List data = hasil['data']??[];
  print(data.toString());
  responSektor = ResponSektor.fromJson(hasil);
  data.forEach((element) {
   myMarker.add(
    Marker(
     markerId: MarkerId(element['nama_sektor']),
     position: LatLng(double.parse(element['latlng']), double.parse(element['lotlng'])),
     infoWindow: InfoWindow(title: element['nama_sektor'],snippet:  element['alamat_sektor']),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
   );
   user.value += 2;
  });
  if(data.isEmpty ){
   user.value = 1;
  }
  myLocation();

 }
 Future<Null>refreshData() async{
  await Future.delayed(Duration(seconds: 2));
  dataSektor(id_call);
 }
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
    } else {
    throw 'Could not open the map.';
    }
  }
 Future<void> buatPanggilan(String url) async {
  await launch('tel:$url');
 }

 myLocation()async{
  Position position = await _determinePosition();
  googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
  // myMarker.clear();
  myMarker.add(
      Marker(
       markerId: const MarkerId('currentLocation'),
       position: LatLng(position.latitude, position.longitude),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
       infoWindow: InfoWindow(title: 'Lokasi Anda'),
      ));
  user.value +=2;
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
 @override
 void onInit() {
  // TODO: implement onInit
  super.onInit();
  id_call = GetStorage().read('id_call');
  dataSektor(id_call);

 }
}