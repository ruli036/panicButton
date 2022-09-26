import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panicbutton/admin/adminController.dart';
import 'package:email_validator/email_validator.dart';
class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _keyboardIsVisible() {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }
    final adminC = Get.find<AdminController>();
    var size = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          title: Text('Tambah Admin'),
        ),
          body: Container(
              height: size.height,
              child: ListView(
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
                    key: adminC.keyform,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: adminC.username,
                            validator: (e){
                              if(e!.isEmpty){
                                return 'Masukkan Username Anda';
                              }
                            },
                            decoration:const InputDecoration(
                                labelText: 'Username',
                                prefixIcon:   Icon(Icons.verified_user,color: Colors.blue,),
                                border:  OutlineInputBorder()
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            controller: adminC.nama,
                            validator: (e){
                              if(e!.isEmpty){
                                return 'Masukkan Nama Anda';
                              }
                            },
                            decoration:const InputDecoration(
                                labelText: 'Nama',
                                prefixIcon:   Icon(Icons.account_circle,color: Colors.blue,),
                                border:  OutlineInputBorder()
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            controller: adminC.email,
                            validator: (e){
                              if (e!.isEmpty) {
                                return 'Masukkan Email';
                              }else if(!EmailValidator.validate(e)){
                                return 'Format Email Salah';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration:const InputDecoration(
                                labelText: 'Email',
                                prefixIcon:   Icon(Icons.email,color: Colors.blue,),
                                border:  OutlineInputBorder()
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                          TextFormField(
                            controller: adminC.alamat,
                            validator: (e){
                              if(e!.isEmpty){
                                return 'Masukkan Alamat Anda';
                              }
                            },
                            maxLines: 3,
                            decoration: const InputDecoration(
                                labelText: 'Alamat',
                                border:  OutlineInputBorder()
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(5)),
                           Container(
                              height: 40,
                              width: size.width,
                              decoration: const BoxDecoration(
                                  color: Colors.indigoAccent,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              // ignore: deprecated_member_use
                              child: TextButton(
                                onPressed: (){
                                  adminC.validasi();
                                },
                                child:const Text("Register",style: TextStyle(color: Colors.white)),
                              )
                          ),
                        ],

                      ),
                    ) ,
                  ),

                ],
              )
          )
      );



  }
}


