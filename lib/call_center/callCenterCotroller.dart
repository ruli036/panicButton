import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Img;
import 'package:panicbutton/sektor/sektorController.dart';
import 'dart:math' as Math;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:panicbutton/call_center/callCenterView.dart';
import 'package:panicbutton/call_center/objectCallCenter.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/alerts.dart';
import 'package:panicbutton/widgets/helpers.dart';
import 'package:panicbutton/widgets/responCrud.dart';
import 'package:path_provider/path_provider.dart';
class CallCenterController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController no_telp = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController instansi = TextEditingController();
  TextEditingController editKet = TextEditingController();
  TextEditingController editNo_telp = TextEditingController();
  TextEditingController editInstansi = TextEditingController();
  final sektorC = Get.find<SektorController>();
  var id_callCenter,editLogo;
  final keyform = GlobalKey<FormState>();
  ResponCrud? responCrud;
  ResponCallCenter? responCallCenter;
  RxInt user =0.obs;
  RxInt cek =0.obs;
  RxInt foto = 0.obs;
  var imageFoto;
  late Animation<Offset> animation;
  late AnimationController animationController;
 // adaskd;lasd
  scrool(notification){
    final ScrollDirection direction = notification.direction;
    if (direction == ScrollDirection.reverse) {
      animationController.forward();
    } else if (direction == ScrollDirection.forward) {
      animationController.reverse();
    }
    return true;
  }
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
  void ambilFoto(ImageSource source)async{

    final picket = ImagePicker();
    var imageFile = await picket.pickImage(source: source);
    imageFoto = File(imageFile!.path);
    if(imageFoto != null){
      AppAlert.loading("Loading", "Harap Tunggu");
      final tempDir = await getTemporaryDirectory();
      String path = tempDir.path;

      int rand = new Math.Random().nextInt(100000);

      Img.Image? iMage = Img.decodeImage(imageFoto!.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(iMage!, width: 500);

      var compressImg = new File("$path/gambar$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

      imageFoto = compressImg;
      foto.value += 1;
      Get.back();
    }
  }
  addCallCenter()async{
    AppAlert.loading("Loading", "Harap Tunggu");
    var steam = new http.ByteStream(imageFoto.openRead());
    var length = await imageFoto.length();
    var uri = Uri.parse(UrlApi.TAMBAH_CALL_CENTER);
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile(
        "image", steam, length, filename: path.basename(imageFoto.path));
    request.fields['instansi'] = instansi.text;
    request.fields['no_telp'] = no_telp.text;
    request.fields['keterangan'] = keterangan.text;
    request.fields['latlng'] = sektorC.langth.text;
    request.fields['lotlng'] = sektorC.longth.text;
    request.files.add(multipartFile);
    var response = await request.send();
    if(response.statusCode != 200){
        Get.back();
        AppAlert.getAlert('Info', "Gagal Menambahkan Data Call Center", ()=>Get.back());
      }else{
        Get.back();
        instansi.text = '';
        no_telp.text = '';
        keterangan.text = '';
        dataCallCenter();
        AppAlert.getAlert('Info', "Berhasil Menambahkan Data Call Center", (){Get.back();Get.back();});
       }
  }
  editCallCenter()async{

    AppAlert.loading("Loading", "Harap Tunggu");
    if(imageFoto != null){
      var steam = new http.ByteStream(imageFoto.openRead());
      var length = await imageFoto.length();
      var uri = Uri.parse(UrlApi.EDIT_CALL_CENTER);
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile(
          "image", steam, length, filename: path.basename(imageFoto.path));
      request.fields['id_call'] = id_callCenter.toString();
      request.fields['instansi'] = editInstansi.text;
      request.fields['no_telp'] = editNo_telp.text;
      request.fields['keterangan'] = editKet.text;
      request.fields['latlng'] = sektorC.langth.text;
      request.fields['lotlng'] = sektorC.longth.text;
      request.files.add(multipartFile);
      var response = await request.send();
      if(response.statusCode != 200){
        Get.back();
        AppAlert.getAlert('Info', "Gagal Mengubah Data Call Center", ()=>Get.back());
      }else{
        Get.back();
        instansi.text = '';
        no_telp.text = '';
        keterangan.text = '';
        dataCallCenter();
        AppAlert.getAlert('Info', "Berhasil Mengubah Data Call Center", (){Get.back();Get.back();});
      }
    }else{
      var uri = Uri.parse(UrlApi.EDIT_CALL_CENTER);
      var request = http.MultipartRequest("POST", uri);
      request.fields['id_call'] = id_callCenter.toString();
      request.fields['instansi'] = editInstansi.text;
      request.fields['no_telp'] = editNo_telp.text;
      request.fields['keterangan'] = editKet.text;
      request.fields['latlng'] = sektorC.langth.text;
      request.fields['lotlng'] = sektorC.longth.text;
      var response = await request.send();
      if(response.statusCode != 200){
        Get.back();
        AppAlert.getAlert('Info', "Gagal Mengubah Data Call Center", ()=>Get.back());
      }else{
        Get.back();
        instansi.text = '';
        no_telp.text = '';
        keterangan.text = '';
        dataCallCenter();
        AppAlert.getAlert('Info', "Berhasil Mengubah Data Call Center", (){Get.back();Get.back();});
      }
    }

  }
  Future<Null>refreshData() async{
    await Future.delayed(Duration(seconds: 2));
    dataCallCenter();
  }
  hapusCallCenter()async{
    Get.back();
    AppAlert.loading("Loading", "Harap Tunggu");
    final respon = await http.post(Uri.parse(UrlApi.HAPUS_CALL_CENTER),
        body: {
          'id_call'  : id_callCenter.toString(),
        }
    );
    final hasil = json.decode(respon.body);
    print(hasil);
    if(hasil['meta']['status'] == false){
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }else{
      Get.back();
      dataCallCenter();
      AppAlert.getAlert('Info', hasil['meta']['message'], ()=>Get.back());
    }
  }
  void validasiadd(){
    final form = keyform.currentState;
    if (form!.validate()) {
      addCallCenter();
    }
  }
  void validasiEdit(){
    final form = keyform.currentState;
    if (form!.validate()) {
      editCallCenter();
    }
  }
  void pilihAction(String choice){
    if(choice == TombolAdmin.edit){
      var lokasiLama = '${sektorC.langth.text}, ${sektorC.longth.text}';
      print("LOKASI LAMA"+lokasiLama.toString());
      sektorC.googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target:LatLng(double.parse(sektorC.langth.text), double.parse(sektorC.longth.text)),zoom: 14)));
      sektorC.myMarker.clear();
      sektorC.myMarker.add(
          Marker(
            markerId: MarkerId(lokasiLama.toString()),
            position: LatLng(double.parse(sektorC.langth.text), double.parse(sektorC.longth.text)),
          )
      );
      cek +=1;
      Get.toNamed('/editCallCenter');
    }else if(choice == TombolAdmin.Hapus){
      AppAlert.getAlertHapus(id_callCenter.toString(),'Warning', "Data Sektor Call Center Ikut Terhapus!", ()=>hapusCallCenter());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dataCallCenter();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<Offset>(end: Offset(0, 2), begin: Offset(0, 0))
        .animate(animationController);
   }
}