import 'dart:convert';

ResponCrud responCrudFromJson(String str) => ResponCrud.fromJson(json.decode(str));

String responCrudToJson(ResponCrud data) => json.encode(data.toJson());

class ResponCrud {
  ResponCrud({
    required this.meta,
    required this.data,
  });

  Meta meta;
  dynamic data;

  factory ResponCrud.fromJson(Map<String, dynamic> json) => ResponCrud(
    meta: Meta.fromJson(json["meta"]),
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": data,
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
