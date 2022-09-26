import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panicbutton/sektor/sektorController.dart';
import 'package:panicbutton/widgets/helpers.dart';

class SektorView extends StatelessWidget {
  const SektorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sektorC = Get.find<SektorController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sektor ${GetStorage().read('instansi').toString().toTitleCase()}"),
      ),
      body: Obx(()=>
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              sektorC.scrool(notification);
              return true;
            },
            child: Container(
                child: sektorC.user.value == 1 ?Center(child: Text("Sektor Kosong"),): sektorC.user.value == 0? Center(child: CircularProgressIndicator(),) :RefreshIndicator (
                  onRefresh: sektorC.refreshData,
                  child: ListView.builder(
                      itemCount: sektorC.responSektor == null ? 0 : sektorC.responSektor!.data.length,
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
                                  offset: const Offset(3.0, 3.0,),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow

                              ],
                            ),
                            child: ListTile(
                              title: Text(sektorC.responSektor!.data[i].namaSektor.toTitleCase()),
                              isThreeLine: true,
                              trailing: PopupMenuButton(
                                onSelected: sektorC.pilihAction,
                                itemBuilder: (BuildContext context) {
                                  sektorC.id_sektor = sektorC.responSektor!.data[i].idSektor;
                                  sektorC.no_telp.text = sektorC.responSektor!.data[i].noTelp;
                                  sektorC.alamatSektor.text = sektorC.responSektor!.data[i].alamatSektor;
                                  sektorC.namaSektor.text = sektorC.responSektor!.data[i].namaSektor;
                                  sektorC.langth.text = sektorC.responSektor!.data[i].latlng;
                                  sektorC.longth.text = sektorC.responSektor!.data[i].lotlng;
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
                                    Text(sektorC.responSektor!.data[i].noTelp.toCapitalized()),
                                    Text(sektorC.responSektor!.data[i].alamatSektor.toCapitalized()),
                                    Text("Langth "+sektorC.responSektor!.data[i].lotlng,style: TextStyle(fontSize: 10),),
                                    Text("Longth "+sektorC.responSektor!.data[i].latlng,style: TextStyle(fontSize: 10),),
                                  ],
                                ),
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
          sektorC.namaSektor.text ='';
          sektorC.alamatSektor.text ='';
          sektorC.no_telp.text ='';
          sektorC.langth.text ='';
          sektorC.longth.text ='';
          sektorC.myMarker.clear();
          Get.toNamed('/addSektor',arguments: Get.parameters['id']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
