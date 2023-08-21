// To parse this JSON data, do
//
//     final servicio = servicioFromJson(jsonString);

import 'dart:convert';

List<Servicio> servicioFromJson(String str) => List<Servicio>.from(json.decode(str).map((x) => Servicio.fromJson(x)));
Servicio oneServicioFromJson(String str) => Servicio.fromJson(json.decode(str));

String servicioToJson(List<Servicio> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Servicio {
    Servicio({
        this.servidor,
        this.codigoServicio,
        this.codigo,
        this.nombre,
        this.descripcion,
        this.timeout,
        this.tipo,
    });
    dynamic servidor;
    int codigoServicio;
    int codigo;
    String nombre;
    dynamic descripcion;
    double timeout;
    dynamic tipo;

    factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        codigoServicio: json["codigoServicio"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        timeout: double.parse(json["timeout"].toString()),
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "codigoServicio": codigoServicio,
        "codigo": codigo,
        "nombre": nombre,
        "descripcion": descripcion,
        "timeout": timeout,
        "tipo": tipo,
    };
}
