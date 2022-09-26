import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panicbutton/feedback/feedBackController.dart';
import 'package:panicbutton/widgets/helpers.dart';

class FeedBackView extends StatelessWidget {
  const FeedBackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedBackC = Get.find<FeedBackController>();
    return Container(
      child: Obx(()=>
          Container(
              child: feedBackC.user.value == 1 ?Center(child: Text("Data Kosong"),): feedBackC.user.value == 0? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
                onRefresh: feedBackC.refreshData,
                child: ListView.builder(
                    itemCount: feedBackC.responFeedBack == null ? 0 : feedBackC.responFeedBack!.data.length,
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
                            title: Text(feedBackC.responFeedBack!.data[i].nama.toUpperCase()),
                            isThreeLine: true,
                            subtitle: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(feedBackC.responFeedBack!.data[i].keterangan.toCapitalized()),
                                  SizedBox(height: 10,),
                                  Text(feedBackC.responFeedBack!.data[i].email,style: TextStyle(fontSize: 13)),
                                  Text("tanggal "+feedBackC.responFeedBack!.data[i].tglFeed,style: TextStyle(fontSize: 10),),
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
    );
  }
}

class AddFeedBack extends StatelessWidget {
  const AddFeedBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedBackC = Get.find<FeedBackController>();
    return Container(
      height: 280,
      width: 300,
      child: ListView(
        children: [
          Container(
            height: 280,
            width: 300,
            child:  Form(
              key: feedBackC.keyform,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: feedBackC.nama,
                      validator: (e){
                        if(e!.isEmpty){
                          return 'Masukkan Nama';
                        }
                      },
                      decoration:const InputDecoration(
                          labelText: 'Nama ',
                          prefixIcon:  Icon(Icons.account_circle,color: Colors.blue,),
                          border: OutlineInputBorder()
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    TextFormField(
                      controller: feedBackC.email,
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
                      controller: feedBackC.keterangan,
                      validator: (e){
                        if(e!.isEmpty){
                          return 'Masukkan Pesan Anda';
                        }
                      },
                      maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: 'Pesan',
                          border: OutlineInputBorder()
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

