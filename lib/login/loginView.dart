import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panicbutton/home/homeView.dart';
import 'package:panicbutton/login/loginController.dart';
import 'package:panicbutton/profile/profileView.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginC = Get.find<LoginController>();
    var size = MediaQuery.of(context).size;
    if(loginC.isLogin == false){
      return Scaffold(
          resizeToAvoidBottomInset : false,
          body: Container(
              height: size.height,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    child: Form(
                      key: loginC.keyform,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: loginC.username,
                              validator: (e){
                                if(e!.isEmpty){
                                  return 'Masukkan Username Anda';
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: const Icon(Icons.account_circle,color: Colors.blue,),
                                  border:const OutlineInputBorder()
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            Obx(()=>
                                TextFormField(
                                  controller: loginC.password,
                                  validator: (e){
                                    if(e!.isEmpty){
                                      return 'Masukkan Password Anda';
                                    }
                                  },
                                  obscureText: loginC.lihatpass.value,
                                  decoration: InputDecoration(
                                    border:const OutlineInputBorder(),
                                    labelText: 'Password ',
                                    prefixIcon: Icon(loginC.lihatpass.value == false ? Icons.lock_open:Icons.lock ),
                                    suffixIcon: IconButton(
                                      icon: Icon(loginC.lihatpass.value == false ? Icons.visibility:Icons.visibility_off ),
                                      onPressed:()=> loginC.lihatpassword(),
                                    ),
                                  ),
                                ),
                            ),

                            const Padding(padding: EdgeInsets.only(bottom: 70)),
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
                                    loginC.validasi();
                                  },
                                  child:const Text("LOGIN",style: TextStyle(color: Colors.white)),
                                )
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            const Center(
                              child: Text('App Ver 1.0.0 - 20013FEA6BCC820C',style: TextStyle(color:Colors.grey)),
                            )
                          ],

                        ),
                      ) ,
                    ),
                    top: 250,
                    right: 0,
                    left: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 130,
                        width: 130,
                        child: ClipOval(child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,))
                      ),
                    ),
                  ),
                 ],
              )
          )
      );
    }else{
      return ProfilePage();
    }


  }
}


