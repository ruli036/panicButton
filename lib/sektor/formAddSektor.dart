import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panicbutton/sektor/sektorController.dart';

class AddSektorView extends StatelessWidget {
  const AddSektorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sektorC = Get.find<SektorController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Sektor'),
      ),
        body: Container(
            height: size.height,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AnimatedContainer(
                    duration:const Duration(milliseconds: 300),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: 130,
                    width: size.width,
                  ),
                ),
                Form(
                  key: sektorC.keyform,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: sektorC.namaSektor,
                          validator: (e){
                            if(e!.isEmpty){
                              return 'Masukkan Nama Sektor';
                            }
                          },
                          decoration:const InputDecoration(
                              labelText: 'Sektor',
                              prefixIcon:   Icon(Icons.verified_user,color: Colors.blue,),
                              border:  OutlineInputBorder()
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                          controller: sektorC.no_telp,
                          validator: (e){
                            if(e!.isEmpty){
                              return 'Masukkan Nomor Telp Sektor';
                            }
                          },
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration:const InputDecoration(
                              labelText: 'Nomor Telpon',
                              prefixIcon:  Icon(Icons.phone,color: Colors.blue,),
                              border: OutlineInputBorder()
                          ),
                        ),
                        // const Padding(padding: EdgeInsets.all(5)),
                        // TextFormField(
                        //   controller: sektorC.langth,
                        //   validator: (e){
                        //     if(e!.isEmpty){
                        //       return 'Masukkan Langth Lokasi';
                        //     }
                        //   },
                        //   keyboardType: TextInputType.number,
                        //   decoration: const InputDecoration(
                        //       labelText: 'Langth',
                        //       prefixIcon:  Icon(Icons.location_on,color: Colors.blue,),
                        //       border:  OutlineInputBorder()
                        //   ),
                        // ),
                        // const Padding(padding: EdgeInsets.all(5)),
                        // TextFormField(
                        //   controller: sektorC.longth,
                        //   validator: (e){
                        //     if(e!.isEmpty){
                        //       return 'Masukkan Longth Lokasi';
                        //     }
                        //   },
                        //   keyboardType: TextInputType.number,
                        //   decoration: const InputDecoration(
                        //       labelText: 'Longth',
                        //     prefixIcon:  Icon(Icons.location_on,color: Colors.blue,),
                        //     border:  OutlineInputBorder(),
                        //   ),
                        // ),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                          controller: sektorC.alamatSektor,
                          validator: (e){
                            if(e!.isEmpty){
                              return 'Masukkan Alamat Sektor';
                            }
                          },
                          maxLines: 3,
                          decoration:const InputDecoration(
                              labelText: 'Alamat',
                              border:  OutlineInputBorder()
                          ),
                        ),
                        MapLocation()
                       ],
                    ),
                  ) ,
                ),

              ],
            )
        ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 40,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // ignore: deprecated_member_use
            child: TextButton(
              onPressed: (){
                if(sektorC.longth.text == ""|| sektorC.langth.text == ""){
                  Get.snackbar("Info", 'Tentukan Lokasi Sektor',snackPosition: SnackPosition.TOP,colorText: Colors.black,backgroundColor: Colors.white,duration: Duration(milliseconds: 1000));
                }else{
                  sektorC.validasiadd();
                }
              },
              child:const Text("Add",style: TextStyle(color: Colors.white)),
            )
        ),
      ),
    );
  }
}

class MapLocation extends StatelessWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sektorC = Get.find<SektorController>();
    var size = MediaQuery.of(context).size;
    return  Obx(()=>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Text(sektorC.cek.value.toString(),style: TextStyle(color: Colors.white),),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                height: size.height / 2.7,
                child:  GoogleMap(
                  initialCameraPosition: sektorC.initialCameraPosition,
                  markers: Set.from(sektorC.myMarker),
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onTap: sektorC.onMapTap,
                  onMapCreated: (GoogleMapController controller) {
                    sektorC.googleMapController = controller;
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: Container(
                  height: 30,
                  child: FloatingActionButton(
                    onPressed: (){
                      sektorC.myLocation();
                    },
                    child: Icon(Icons.location_on,color: Colors.white,size: 15,),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

