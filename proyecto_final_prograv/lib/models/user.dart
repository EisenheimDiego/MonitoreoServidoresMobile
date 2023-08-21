// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    Usuario({
        this.usuario,
        this.correo,
        this.contrasena,
    });

    String usuario;
    String correo;
    String contrasena;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuario: json["usuario"],
        correo: json["correo"],
        contrasena: json["contrasena"],
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "correo": correo,
        "contrasena": contrasena,
    };
}
