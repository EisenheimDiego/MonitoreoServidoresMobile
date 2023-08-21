// To parse this JSON data, do
//
//     final servidor = servidorFromJson(jsonString);

import 'dart:convert';

List<Servidor> servidorFromJson(String str) => List<Servidor>.from(json.decode(str).map((x) => Servidor.fromJson(x)));
Servidor oneServidorFromJson(String str) => Servidor.fromJson(json.decode(str));

String servidorToJson(List<Servidor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Servidor {
    Servidor({
        this.codigo,
        this.nombre,
        this.descripcion,
        this.usuarioAdmin,
        this.contrasena,
    });

    int codigo;
    String nombre;
    dynamic descripcion;
    String usuarioAdmin;
    String contrasena;
    double cpuMin;
    double memMin;
    double discoMin;
    double cpuMax;
    double memMax;
    double discoMax;

    factory Servidor.fromJson(Map<String, dynamic> json) => Servidor(
        codigo: json["codigo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        usuarioAdmin: json["usuarioAdmin"],
        contrasena: json["contrasena"],
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nombre": nombre,
        "descripcion": descripcion,
        "usuarioAdmin": usuarioAdmin,
        "contrasena": contrasena,
    };
}
