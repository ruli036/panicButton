import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panicbutton/feedback/feedBackController.dart';
import 'package:panicbutton/feedback/feedbackView.dart';
import 'package:panicbutton/home/homeCotroller.dart';
import 'package:panicbutton/server/api.dart';
import 'package:panicbutton/widgets/helpers.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeCotroller>();
    final feedBackC = Get.put(FeedBackController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Call"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,)),
        ),
        actions: [
          IconButton(
              onPressed: (){
                Get.toNamed('/login');
              },
              icon:Icon(Icons.account_circle)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: homeC.refreshData,
          child: Obx(()=>homeC.user.value == 1 || homeC.user.value == 0 ? const Center(child: CircularProgressIndicator(),) :
             ListView(
              children: [
                 const Text("INFORMASI LAYANAN",style:TextStyle(fontWeight: FontWeight.bold) ,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(homeC.infoApp.toString().toCapitalized(),textAlign: TextAlign.justify,),
                 ),
                Divider(),
                const SizedBox(height: 20,),
                Container(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: List.generate(homeC.responCallCenter == null?0:homeC.responCallCenter!.data.length  , (index) {
                      return GestureDetector(
                        onTap: (){
                          GetStorage().write("id_call",homeC.responCallCenter!.data[index].idCall.toString() );
                          GetStorage().write("instansi",homeC.responCallCenter!.data[index].instansi.toString() );
                          GetStorage().write("no_call",homeC.responCallCenter!.data[index].noTelp.toString() );
                          GetStorage().write("logo_instansi",homeC.responCallCenter!.data[index].logo.toString() );
                          GetStorage().write("call_langth",homeC.responCallCenter!.data[index].latlng.toString() );
                          GetStorage().write("call_longth",homeC.responCallCenter!.data[index].lotlng.toString() );
                          Get.toNamed('/layanan');
                        },
                        child: Container(
                          width: size.width/3.4,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                )
                              ]
                          ),
                          child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 50,width: 50,
                                      child: ClipOval(
                                          child: Image.network( Server.IMAGE +homeC.responCallCenter!.data[index].logo ,fit: BoxFit.cover,)
                                      )
                                  ),
                                ),
                                Text(homeC.responCallCenter!.data[index].instansi.toUpperCase(),style: TextStyle(fontWeight:FontWeight.bold),)
                              ]
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20,),
                Divider(),
                const Text("IKLAN LAYANAN",style:TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Column(
                 children: [
                   Container(
                     height: 120,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                         image:const DecorationImage(
                           image: NetworkImage(
                             'https://pemmzchannel.com/wp-content/uploads/2018/01/apa-itu-APK.jpg',
                           ),
                           fit: BoxFit.cover,
                           repeat: ImageRepeat.noRepeat,
                         ),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.shade400,
                             offset: const Offset(3.0, 3.0),
                             blurRadius: 5.0,
                             spreadRadius: 1.0,
                           )
                         ]
                     ),
                   ),
                   Container(
                     height: 70,
                     decoration: BoxDecoration(
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.shade400,
                             offset: const Offset(3.0, 3.0,),
                             blurRadius: 5.0,
                             spreadRadius: 1.0,
                           )
                         ]
                     ),
                     child:const Padding(
                       padding:  EdgeInsets.all(5),
                       child: Text('Bottomsheets are the sheets displayed at the bottom to show any content which we want to display. Normally, when we create bottomsheet .',textAlign: TextAlign.justify,),
                     ),
                   )
                 ],
               ),
                const SizedBox(height: 10,),
                Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          image:const DecorationImage(
                            image: NetworkImage(
                              'https://www.jatimtech.com/wp-content/uploads/Gambar-1-Apa-yang-dimaksud-dengan-APK.jpg',
                            ),
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat,
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(3.0, 3.0),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            )
                          ]
                      ),
                    ),
                    Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(3.0, 3.0,),
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            )
                          ]
                      ),
                      child:const Padding(
                        padding:  EdgeInsets.all(5),
                        child: Text('Bottomsheets are the sheets displayed at the bottom to show any content which we want to display. Normally, when we create bottomsheet .',textAlign: TextAlign.justify,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.defaultDialog(
            title: "Beri Masukan!",
            content: AddFeedBack(),
            confirmTextColor: Colors.white,
            textConfirm: "Submit",
            textCancel: 'Close',
            onConfirm: (){
              feedBackC.validasiadd();
            }
          );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}



