// To parse this JSON data, do
//
//     final correo = correoFromJson(jsonString);

import 'dart:convert';

Correo correoFromJson(String str) => Correo.fromJson(json.decode(str));

String correoToJson(Correo data) => json.encode(data.toJson());

class Correo {
    Correo({
        this.nombreServidor,
        this.encargados,
    });

    String nombreServidor;
    List<String> encargados;

    factory Correo.fromJson(Map<String, dynamic> json) => Correo(
        nombreServidor: json["nombreServidor"],
        encargados: List<String>.from(json["encargados"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "nombreServidor": nombreServidor,
        "encargados": List<dynamic>.from(encargados.map((x) => x)),
    };
}
