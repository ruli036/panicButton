import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panicbutton/admin/adminController.dart';
import 'package:panicbutton/profile/profileController.dart';
import 'package:panicbutton/widgets/helpers.dart';
class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileC = Get.find<ProfileController>();
    final adminC = Get.put(AdminController());
     return Scaffold(
      body: Obx(()=>
          NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              adminC.scrool(notification);
              return true;
            },
          child: Container(
            child: profileC.user.value == 1 ?Center(child: Text("User Kosong"),): profileC.user.value == 0? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
              onRefresh: adminC.refreshData,
              child: ListView.builder(
                itemCount: profileC.adminObject == null ? 0 : profileC.adminObject!.data.length,
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
                        title: Text(profileC.adminObject!.data[i].username),
                        isThreeLine: true,
                        trailing: PopupMenuButton(
                          onSelected: adminC.pilihAction,
                          itemBuilder: (BuildContext context) {
                            adminC.id_user = profileC.adminObject!.data[i].idUser;
                            adminC.editAlamat.text = profileC.adminObject!.data[i].alamat;
                            adminC.editEmail.text = profileC.adminObject!.data[i].email;
                            adminC.editNama.text = profileC.adminObject!.data[i].nama;
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
                              Text(profileC.adminObject!.data[i].nama.toUpperCase()),
                              Text(profileC.adminObject!.data[i].email.toLowerCase()),
                              Text(profileC.adminObject!.data[i].alamat.toLowerCase()),
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
      floatingActionButton: SlideTransition(
        position: adminC.animation,
        child: FloatingActionButton(
          onPressed: (){
            Get.toNamed('/register');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class EditAdminView extends StatelessWidget {
  const EditAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminC = Get.find<AdminController>();
    return Container(
      height: 250,
      width: 300,
      child: ListView(
        children: [
          Container(
            child:  Form(
              key: adminC.keyform2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: adminC.editNama,
                      validator: (e){
                        if(e!.isEmpty){
                          return 'Masukkan Nama Anda';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Nama',
                          prefixIcon: const Icon(Icons.account_circle,color: Colors.blue,),
                          border:const OutlineInputBorder()
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      controller: adminC.editEmail,
                      validator: (e){
                        if (e!.isEmpty) {
                          return 'Masukkan Email';
                        }else if(!EmailValidator.validate(e)){
                          return 'Format Email Salah';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email,color: Colors.blue,),
                          border:const OutlineInputBorder()
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      controller: adminC.editAlamat,
                      validator: (e){
                        if(e!.isEmpty){
                          return 'Masukkan Alamat Anda';
                        }
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                          labelText: 'Alamat',
                          border:const OutlineInputBorder()
                      ),
                    ),
                  ],
                ),
              ) ,
            ),
          )
        ],
      ),
    );
  }
}

class InfoAppView extends StatelessWidget {
  const InfoAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adminC = Get.find<ProfileController>();
    return Container(
      child: Form(
        key: adminC.keyform,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: adminC.emailApp,
                validator: (e){
                  if (e!.isEmpty) {
                    return 'Masukkan Email';
                  }else if(!EmailValidator.validate(e)){
                    return 'Format Email Salah';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email,color: Colors.blue,),
                    border:const OutlineInputBorder()
                ),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              TextFormField(
                controller: adminC.infoApp,
                validator: (e){
                  if(e!.isEmpty){
                    return 'Masukkan Info Tentang App';
                  }
                },
                maxLines: 3,
                decoration: InputDecoration(
                    labelText: 'Info',
                    border:const OutlineInputBorder()
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}

