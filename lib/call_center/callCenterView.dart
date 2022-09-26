import 'dart:io';
import 'package:panicbutton/sektor/formAddSektor.dart';
import 'package:panicbutton/server/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panicbutton/call_center/callCenterCotroller.dart';
import 'package:panicbutton/widgets/helpers.dart';

class CallCenterView extends StatelessWidget {
  const CallCenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final callCenterC = Get.find<CallCenterController>();
    return Scaffold(
      body: Obx(()=>
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              callCenterC.scrool(notification);
              return true;
            },
            child: Container( 
                child: callCenterC.user.value == 1 ?Center(child: Text("Call Center Kosong"),):callCenterC.user.value == 0? Center(child: CircularProgressIndicator(),): RefreshIndicator(
                  onRefresh: callCenterC.refreshData,
                  child: ListView.builder(
                      itemCount: callCenterC.responCallCenter == null ? 0 : callCenterC.responCallCenter!.data.length,
                      itemBuilder: (context, i){
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: const Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow

                              ],
                            ),
                            child: ListTile(
                              onTap: (){
                                GetStorage().write("id_call",callCenterC.responCallCenter!.data[i].idCall.toString() );
                                GetStorage().write("instansi",callCenterC.responCallCenter!.data[i].instansi.toString() );
                                callCenterC.sektorC.user.value = 0;
                                callCenterC.sektorC.id_call = callCenterC.responCallCenter!.data[i].idCall.toString();
                                callCenterC.sektorC.dataSektor(callCenterC.responCallCenter!.data[i].idCall.toString());
                                Get.toNamed('/sektor' );
                              },
                              title: Text(callCenterC.responCallCenter!.data[i].instansi.toUpperCase() + " (${callCenterC.responCallCenter!.data[i].noTelp})"),
                              isThreeLine: true,
                              trailing: PopupMenuButton(
                                onSelected: callCenterC.pilihAction,
                                itemBuilder: (BuildContext context) {
                                  callCenterC.foto.value = 0;
                                  callCenterC.id_callCenter = callCenterC.responCallCenter!.data[i].idCall;
                                  callCenterC.editKet.text = callCenterC.responCallCenter!.data[i].keterangan;
                                  callCenterC.editInstansi.text = callCenterC.responCallCenter!.data[i].instansi;
                                  callCenterC.editNo_telp.text = callCenterC.responCallCenter!.data[i].noTelp;
                                  callCenterC.editLogo = callCenterC.responCallCenter!.data[i].logo;
                                  callCenterC.sektorC.longth.text = callCenterC.responCallCenter!.data[i].lotlng;
                                  callCenterC.sektorC.langth.text = callCenterC.responCallCenter!.data[i].latlng;

                                  print( callCenterC.sektorC.longth.text);
                                  return TombolAdmin.Pilih.map((String pilih){
                                    return PopupMenuItem<String>(
                                      value: pilih,
                                      child: Text(pilih),
                                    );
                                  }).toList();
                                },
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(callCenterC.responCallCenter!.data[i].keterangan.toCapitalized()),
                                    Text("Langth "+callCenterC.responCallCenter!.data[i].latlng,style: TextStyle(fontSize: 10),),
                                    Text("Longth "+callCenterC.responCallCenter!.data[i].lotlng,style: TextStyle(fontSize: 10),),
                                  ],
                                ),
                              ),
                              leading: SizedBox(
                                  height: 50,width: 50,
                                  child: ClipOval(child: Image.network( Server.IMAGE +callCenterC.responCallCenter!.data[i].logo ,fit: BoxFit.cover,)
                                  )
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
            ),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          callCenterC.foto.value = 0;
          callCenterC.sektorC.longth.text = '';
          callCenterC.sektorC.langth.text = '';
          Get.toNamed('/addCallCenter');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddCallCenter extends StatelessWidget {
  const AddCallCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final callCenterC = Get.find<CallCenterController>();
    var size = MediaQuery.of(context).size;
    print(callCenterC.foto.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Call Center",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
      ),),
      body: Container(
        child:  Form(
          key: callCenterC.keyform,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  height: 150,
                  child: Stack(
                    children: [
                      Obx(()=>
                         Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            child: callCenterC.foto.value == 0
                                ? ClipOval(child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,))
                                : ClipOval(child: Image.file(File(callCenterC.imageFoto.path),fit: BoxFit.cover,)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: size.width/4,
                        child: ClipOval(
                          child: Container(
                            color: Colors.blue,
                            child: IconButton(
                                onPressed: (){
                                  callCenterC.ambilFoto(ImageSource.gallery);
                                } ,
                                icon:Icon(Icons.image,color: Colors.white,)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.instansi,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Nama Instansi';
                    }
                  },
                  decoration:const InputDecoration(
                      labelText: 'Nama Instansi',
                      prefixIcon:  Icon(Icons.home_work_outlined,color: Colors.blue,),
                      border: OutlineInputBorder()
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.no_telp,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Nomor Telp Call Center';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration:const InputDecoration(
                      labelText: 'Call Center',
                      prefixIcon:  Icon(Icons.phone,color: Colors.blue,),
                      border: OutlineInputBorder()
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.keterangan,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Alamat Anda';
                    }
                  },
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder()
                  ),
                ),
                MapLocation()
              ],
            ),
          ) ,
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 40,
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            // ignore: deprecated_member_use
            child: TextButton(
              onPressed: (){
                if(callCenterC.foto.value == 0){
                  Get.snackbar("Info", 'Masukkan Logo Instansi',snackPosition: SnackPosition.TOP,colorText: Colors.black,backgroundColor: Colors.white,duration: Duration(milliseconds: 1000));
                }else{
                  callCenterC.validasiadd();
                }
              },
              child:const Text("Add",style: TextStyle(color: Colors.white)),
            )
        ),
      ),
    );
  }
}
class EditCallCenter extends StatelessWidget {
  const EditCallCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final callCenterC = Get.find<CallCenterController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Call Center",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
        ),),
      body: Container(
        child:  Form(
          key: callCenterC.keyform,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  height: 150,
                  child: Stack(
                    children: [
                      Obx(()=>
                          Center(
                            child: Container(
                              height: 130,
                              width: 130,
                              child: callCenterC.foto.value == 0
                                  ? ClipOval(child: Image.network(Server.IMAGE + callCenterC.editLogo ,fit: BoxFit.cover,))
                                  : ClipOval(child: Image.file(File(callCenterC.imageFoto.path),fit: BoxFit.cover,)),
                            ),
                          ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: size.width/4,
                        child: ClipOval(
                          child: Container(
                            color: Colors.blue,
                            child: IconButton(
                                onPressed: (){
                                  callCenterC.ambilFoto(ImageSource.gallery);
                                } ,
                                icon:Icon(Icons.image,color: Colors.white,)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.editInstansi,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Nama Instansi';
                    }
                  },
                  decoration:const InputDecoration(
                      labelText: 'Nama Instansi',
                      prefixIcon:  Icon(Icons.home_work_outlined,color: Colors.blue,),
                      border: OutlineInputBorder()
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.editNo_telp,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Nomor Telp Call Center';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration:const InputDecoration(
                      labelText: 'Call Center',
                      prefixIcon:  Icon(Icons.phone,color: Colors.blue,),
                      border: OutlineInputBorder()
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  controller: callCenterC.editKet,
                  validator: (e){
                    if(e!.isEmpty){
                      return 'Masukkan Alamat Anda';
                    }
                  },
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'Alamat',
                      border: OutlineInputBorder()
                  ),
                ),
                MapLocation(),
                // Text(callCenterC.sektorC.cek.value.toString(),style: TextStyle(color: Colors.white),),
              ],
            ),
          ) ,
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 40,
            width: size.width,
            decoration: const BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            // ignore: deprecated_member_use
            child: TextButton(
              onPressed: (){
                  callCenterC.validasiEdit();
              },
              child:const Text("Simpan",style: TextStyle(color: Colors.white)),
            )
        ),
      ),
    );
  }
}

