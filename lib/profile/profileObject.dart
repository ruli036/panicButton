import 'dart:convert';

ResponApp responAppFromJson(String str) => ResponApp.fromJson(json.decode(str));

String responAppToJson(ResponApp data) => json.encode(data.toJson());

class ResponApp {
  ResponApp({
    required this.meta,
    required this.data,
  });

  Meta meta;
  Data data;

  factory ResponApp.fromJson(Map<String, dynamic> json) => ResponApp(
    meta: Meta.fromJson(json["meta"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.idApp,
    required this.info,
    required this.email,
    required this.tglUpdate,
  });

  int idApp;
  String info;
  String email;
  String tglUpdate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idApp: json["id_app"],
    info: json["info"],
    email: json["email"],
    tglUpdate: json["tgl_update"],
  );

  Map<String, dynamic> toJson() => {
    "id_app": idApp,
    "info": info,
    "email": email,
    "tgl_update": tglUpdate,
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
