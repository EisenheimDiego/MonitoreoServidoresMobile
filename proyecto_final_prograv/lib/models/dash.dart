// To parse this JSON data, do
//
//     final dash = dashFromJson(jsonString);

import 'dart:convert';

Dash dashFromJson(String str) => Dash.fromJson(json.decode(str));

String dashToJson(List<Dash> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Dash {
    Dash({
        this.codigo,
        this.nombre,
        this.estado,
        this.fecha,
        this.cpu,
        this.disco,
        this.memoria,
        this.monitoreoServicios,
        this.encargados,
    });

    int codigo;
    String nombre;
    String estado;
    DateTime fecha;
    double cpu;
    double disco;
    double memoria;
    List<MonitoreoServicio> monitoreoServicios;
    List<String> encargados;
    String usuario;

    factory Dash.fromJson(Map<String, dynamic> json) => Dash(
        codigo: json["codigo"],
        nombre: json["nombre"],
        estado: json["estado"],
        fecha: DateTime.parse(json["fecha"]),
        cpu: double.parse(json["cpu"].toString()),
        disco: double.parse(json["disco"].toString()),
        memoria: double.parse(json["memoria"].toString()),
        monitoreoServicios: List<MonitoreoServicio>.from(json["monitoreoServicios"].map((x) => MonitoreoServicio.fromJson(x))),
        encargados: List<String>.from(json["encargados"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nombre": nombre,
        "estado": estado,
        "fecha": fecha.toIso8601String(),
        "cpu": cpu,
        "disco": disco,
        "memoria": memoria,
        "monitoreoServicios": List<dynamic>.from(monitoreoServicios.map((x) => x.toJson())),
        "encargados": List<dynamic>.from(encargados.map((x) => x)),
    };
}

class MonitoreoServicio {
    MonitoreoServicio({
        this.nombre,
        this.estado,
        this.encargados,
    });

    String nombre;
    String estado;
    List<String> encargados;

    factory MonitoreoServicio.fromJson(Map<String, dynamic> json) => MonitoreoServicio(
        nombre: json["nombre"],
        estado: json["estado"],
        encargados: List<String>.from(json["encargados"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "estado": estado,
        "encargados": List<dynamic>.from(encargados.map((x) => x)),
    };
}
