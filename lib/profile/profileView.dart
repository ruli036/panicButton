import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panicbutton/call_center/callCenterView.dart';
import 'package:panicbutton/feedback/feedbackView.dart';
import 'package:panicbutton/admin/adminView.dart';
import 'package:panicbutton/profile/profileController.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  late TabController control;
  final profileC = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    control =TabController(length: 3,vsync: this );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return profileC.back();
      },
      child: Scaffold(
          appBar: AppBar(
            leading:const Icon(Icons.account_circle,size: 50,),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${profileC.nama.toString().toUpperCase()}"),
                Text("${profileC.email.toString().toLowerCase()}",style: TextStyle(fontSize: 12),),
              ],
            ),
            actions: [
              IconButton(
                  onPressed:(){
                    Get.defaultDialog(
                      title:"Ubah Data App?",
                      textConfirm: "Ubah",
                      textCancel: "Batal",
                      confirmTextColor: Colors.white,
                      content: InfoAppView(),
                      onConfirm: (){
                        profileC.validasiApp();
                      },
                    );
                  },
                  icon:Icon(Icons.info_outline)
              ),
              IconButton(
                  onPressed:(){
                    Get.defaultDialog(
                      title:"Ganti Password?",
                      textConfirm: "Ubah",
                      textCancel: "Batal",
                      confirmTextColor: Colors.white,
                      content: Column(
                        children: [
                          Form(
                              child: TextFormField(
                                controller: profileC.gantiPass,
                                validator: (e){
                                  if(e!.isEmpty){
                                    return 'Masukkan Password Anda';
                                  }
                                },
                                decoration:const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password ',
                                  prefixIcon: Icon( Icons.lock_open ),
                                ),
                              ),
                            key: profileC.keyform,
                          )

                        ],
                      ),
                      onConfirm: (){
                        profileC.validasi();
                      },
                    );
                  },
                  icon:Icon(Icons.lock_outlined)
              ),
              IconButton(
                  onPressed:(){
                    profileC.LogOut();
                  },
                  icon:Icon(Icons.logout)
              )
            ],
            bottom: TabBar(
              controller: control,
              tabs: const <Widget>[
                Tab(child:
                Text("Call Center",style: TextStyle(color: Colors.white,),),
                ),
                Tab(child:
                Text("Admin",style: TextStyle(color: Colors.white,),),
                ),
                Tab(child:
                Text("Feed Back",style: TextStyle(color: Colors.white,),),
                ),
              ],
            ),
          ),
        body: TabBarView(
          controller: control,
          children: const[
            CallCenterView(),
            AdminView(),
            FeedBackView(),
          ],
        ),
      ),
    );
  }
}
