import 'dart:convert';

ResponFeedBack responFeedBackFromJson(String str) => ResponFeedBack.fromJson(json.decode(str));

String responFeedBackToJson(ResponFeedBack data) => json.encode(data.toJson());

class ResponFeedBack {
  ResponFeedBack({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory ResponFeedBack.fromJson(Map<String, dynamic> json) => ResponFeedBack(
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.idFeed,
    required this.nama,
    required this.email,
    required this.keterangan,
    required this.tglFeed,
  });

  int idFeed;
  String nama;
  String email;
  String keterangan;
  String tglFeed;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idFeed: json["id_feed"],
    nama: json["nama"],
    email: json["email"],
    keterangan: json["keterangan"],
    tglFeed: json["tgl_feed"],
  );

  Map<String, dynamic> toJson() => {
    "id_feed": idFeed,
    "nama": nama,
    "email": email,
    "keterangan": keterangan,
    "tgl_feed": tglFeed,
  };
}

class Meta {
  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  int code;
  bool status;
  String message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}
