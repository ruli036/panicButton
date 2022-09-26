import 'dart:convert';

ResponCallCenter responCallCenterFromJson(String str) => ResponCallCenter.fromJson(json.decode(str));

String responCallCenterToJson(ResponCallCenter data) => json.encode(data.toJson());

class ResponCallCenter {
  ResponCallCenter({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory ResponCallCenter.fromJson(Map<String, dynamic> json) => ResponCallCenter(
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
    required this.idCall,
    required this.logo,
    required this.noTelp,
    required this.keterangan,
    required this.instansi,
    required this.tglBuat,
    required this.tglUpdate,
    required this.latlng,
    required this.lotlng,
  });

  int idCall;
  String noTelp;
  String keterangan;
  String lotlng;
  String latlng;
  String logo;
  String instansi;
  String tglBuat;
  String tglUpdate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idCall: json["id_call"],
    logo: json["logo"],
    noTelp: json["no_telp"],
    keterangan: json["keterangan"],
    lotlng: json["lotlng"],
    latlng: json["latlng"],
    instansi: json["instansi"],
    tglBuat: json["tgl_buat"],
    tglUpdate: json["tgl_update"],
  );

  Map<String, dynamic> toJson() => {
    "id_call": idCall,
    "logo": logo,
    "no_telp": noTelp,
    "keterangan": keterangan,
    "latlng": latlng,
    "lotlng": lotlng,
    "instansi": instansi,
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
