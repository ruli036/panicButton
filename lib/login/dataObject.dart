import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.meta,
    required this.data,
  });

  Meta meta;
  Data data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    meta: Meta.fromJson(json["meta"]),
    data: Data.fromJson(json["data"]??{}),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.idUser,
    required this.username,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.password,
    required this.tglBuat,
    required this.tglAktif,
  });

  int? idUser;
  String? username;
  String? nama;
  String? email;
  String? alamat;
  String? password;
  String? tglBuat;
  String? tglAktif;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
