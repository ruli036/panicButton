import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panicbutton/layananTerdekat/terdekatController.dart';
import 'package:panicbutton/widgets/helpers.dart';

class LayananTerdekatView extends StatelessWidget {
  const LayananTerdekatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final terdekatC = Get.find<LayananTerdekatController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sektor Terdekat '),
      ),
      body: Column(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          Obx(()=>
              Stack(
              children: [
                Text(terdekatC.user.value.toString(),),
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
                  height: size.height/2.5,
                  child:  GoogleMap(
                    initialCameraPosition: terdekatC.initialCameraPosition,
                    markers: Set.from(terdekatC.myMarker),
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      terdekatC.googleMapController = controller;
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
                          terdekatC.myLocation();
                      },
                      child: Icon(Icons.location_on,color: Colors.white,size: 15,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(child: ItemSektorTerdekat())
        ],
      ),
    );
  }
}
class ItemSektorTerdekat extends StatelessWidget {
  const ItemSektorTerdekat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final terdekatC = Get.find<LayananTerdekatController>();
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(()=>
          Container(
              child:  terdekatC.user.value == 1 ?Container(height: size.height /2 ,child: Center(child: Text("Sektor Kosong")),): terdekatC.user.value == 0? Container(height: size.height /2 , child: Center(child: CircularProgressIndicator())):
              ListView.builder(
                itemCount:  terdekatC.responSektor == null ? 0 : terdekatC.responSektor!.data.length,
                  itemBuilder:(context, index){
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
                        child: Stack(
                            children: [
                              ListTile(
                                title: Text(terdekatC.responSektor!.data[index].namaSektor.toCapitalized()),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(terdekatC.responSektor!.data[index].noTelp.toCapitalized()),
                                      SizedBox(width:size.width / 1.5 , child: Text(terdekatC.responSektor!.data[index].alamatSektor.toCapitalized(),overflow: TextOverflow.ellipsis)),
                                      // Text("Langth "+terdekatC.responSektor!.data[index].latlng,style: TextStyle(fontSize: 10),),
                                      // Text("Longth "+terdekatC.responSektor!.data[index].lotlng,style: TextStyle(fontSize: 10),),
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
                                          terdekatC.buatPanggilan(terdekatC.responSektor!.data[index].noTelp.toString());
                                        },
                                        icon: Icon(Icons.phone,color: Colors.green),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          terdekatC.openMap(double.parse(terdekatC.responSektor!.data[index].latlng.toString()),double.parse(terdekatC.responSektor!.data[index].lotlng.toString()));
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
                  }
              )
          ),
      ),
    );
  }
}

