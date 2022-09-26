import 'dart:convert';

ResponSektor responSektorFromJson(String str) => ResponSektor.fromJson(json.decode(str));

String responSektorToJson(ResponSektor data) => json.encode(data.toJson());

class ResponSektor {
  ResponSektor({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory ResponSektor.fromJson(Map<String, dynamic> json) => ResponSektor(
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
    required this.idSektor,
    required this.idCall,
    required this.namaSektor,
    required this.alamatSektor,
    required this.noTelp,
    required this.latlng,
    required this.lotlng,
    required this.tglBuat,
    required this.tglUpdate,
  });

  int idSektor;
  int idCall;
  String namaSektor;
  String alamatSektor;
  String noTelp;
  String latlng;
  String lotlng;
  String tglBuat;
  String tglUpdate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idSektor: json["id_sektor"],
    idCall: json["id_call"],
    namaSektor: json["nama_sektor"],
    alamatSektor: json["alamat_sektor"],
    noTelp: json["no_telp"],
    latlng: json["latlng"],
    lotlng: json["lotlng"],
    tglBuat: json["tgl_buat"],
    tglUpdate: json["tgl_update"],
  );

  Map<String, dynamic> toJson() => {
    "id_sektor": idSektor,
    "id_call": idCall,
    "nama_sektor": namaSektor,
    "alamat_sektor": alamatSektor,
    "no_telp": noTelp,
    "latlng": latlng,
    "lotlng": lotlng,
    "tgl_buat": tglBuat,
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
