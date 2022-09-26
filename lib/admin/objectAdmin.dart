// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    meta: Meta.fromJson(json["meta"]??{}),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.idUser,
    required this.username,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.password,
    required this.tglBuat,
    required this.tglAktif,
  });

  int idUser;
  String username;
  String nama;
  String email;
  String alamat;
  String password;
  String tglBuat;
  String tglAktif;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idUser: json["id_user"]??0,
    username: json["username"]??"",
    nama: json["nama"]??"",
    email: json["email"]??"",
    alamat: json["alamat"]??"",
    password: json["password"]??"",
    tglBuat: json["tgl_buat"]??"",
    tglAktif: json["tgl_aktif"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "nama": nama,
    "email": email,
    "alamat": alamat,
    "password": password,
    "tgl_buat": tglBuat,
    "tgl_aktif": tglAktif,
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


ResponRegisAdmin responRegisAdminFromJson(String str) => ResponRegisAdmin.fromJson(json.decode(str));

String responRegisAdminToJson(ResponRegisAdmin data) => json.encode(data.toJson());

class ResponRegisAdmin {
  ResponRegisAdmin({
    required this.meta,
    required this.data,
  });

  Meta2 meta;
  dynamic data;

  factory ResponRegisAdmin.fromJson(Map<String, dynamic> json) => ResponRegisAdmin(
    meta: Meta2.fromJson(json["meta"]),
    data: json["data"]??{},
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data,
  };
}

class Meta2 {
  Meta2({
    required this.code,
    required this.status,
    required this.message,
  });

  int code;
  bool status;
  String message;

  factory Meta2.fromJson(Map<String, dynamic> json) => Meta2(
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

