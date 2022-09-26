import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:panicbutton/sektor/formAddSektor.dart';
import 'package:panicbutton/sektor/sektorController.dart';

class EditSektorView extends StatelessWidget {
  const EditSektorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sektorC = Get.find<SektorController>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Sektor'),
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
      bottomNavigationBar: Padding(
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
                sektorC.validasiedit();
              },
              child:const Text("Simpan",style: TextStyle(color: Colors.white)),
            )
        ),
      ),
    );
  }
}
