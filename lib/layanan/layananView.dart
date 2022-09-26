import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:panicbutton/layanan/layananController.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/helpers.dart';

class LayananView extends StatelessWidget {
  const LayananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layananC = Get.find<LayananController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(layananC.instansi.toString().toTitleCase()),
      ),
      body:  NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          layananC.scrool(notification);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: layananC.refreshData,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    layananC.buatPanggilan(layananC.no_callCenter.toString());
                  },
                  child:  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              Server.IMAGE + layananC.logo_instansi),
                          fit: BoxFit.cover,
                        ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(3.0, 3.0,),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                      ]
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(layananC.no_callCenter.toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child:  Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20))
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      layananC.buatPanggilan(layananC.no_callCenter.toString());
                                    },
                                    icon: Icon(Icons.phone,color: Colors.green),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      layananC.openMap(double.parse(layananC.call_langth),double.parse(layananC.call_longth));
                                    },
                                    icon: Icon(Icons.directions,color: Colors.blue),
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(height: 20,),
                ItemSektor()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SlideTransition(
        position: layananC.animation,
        child: FloatingActionButton(
          onPressed: (){
            Get.toNamed('/terdekat');
          },
          child: Icon(Icons.map_outlined),
        ),
      ),
    );
  }
}

class ItemSektor extends StatelessWidget {
  const ItemSektor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layananC = Get.find<LayananController>();
    final size = MediaQuery.of(context).size;
    return Obx(()=>
        layananC.user.value == 1 ?Container(height:size.height / 2.1,child: Center(child: Text("Sektor Kosong"),)): layananC.user.value == 0? Container(height:size.height / 2.1,child: Center(child: CircularProgressIndicator(),)) :
        Container(
        child: Column(
          children: List.generate(layananC.responSektor == null ?0:layananC.responSektor!.data.length, (index) {
            return
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
                    child: Stack(
                      children: [
                        ListTile(
                          title: Text(layananC.responSektor!.data[index].namaSektor.toCapitalized()),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(layananC.responSektor!.data[index].noTelp.toCapitalized()),
                                SizedBox(width:size.width / 1.5 , child: Text(layananC.responSektor!.data[index].alamatSektor.toCapitalized() )),
                                // Text("Langth "+layananC.responSektor!.data[index].latlng,style: TextStyle(fontSize: 10),),
                                // Text("Longth "+layananC.responSektor!.data[index].lotlng,style: TextStyle(fontSize: 10),),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                            right: 0,
                            child:  Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    layananC.buatPanggilan(layananC.responSektor!.data[index].noTelp.toString());
                                  },
                                  icon: Icon(Icons.phone,color: Colors.green),
                                ),
                                IconButton(
                                  onPressed: (){
                                    layananC.openMap(double.parse(layananC.responSektor!.data[index].latlng.toString()),double.parse(layananC.responSektor!.data[index].lotlng.toString()));
                                  },
                                  icon: Icon(Icons.directions,color: Colors.blue),
                                ),
                              ],
                            )
                        )
                      ]
                    ),
                  ),
                );
          }),
        ),
      ),
    );
  }
}

