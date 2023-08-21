// To parse this JSON data, do
//
//     final componente = componenteFromJson(jsonString);

import 'dart:convert';

List<Componente> componenteFromJson(String str) => List<Componente>.from(json.decode(str).map((x) => Componente.fromJson(x)));

String componenteToJson(List<Componente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Componente {
    Componente({
        this.codigo,
        this.codigoC,
        this.codigoUmbral,
        this.porcentaje,
    });

    int codigo;
    int codigoC;
    int codigoUmbral;
    double porcentaje;

    factory Componente.fromJson(Map<String, dynamic> json) => Componente(
        codigo: json["codigo"],
        codigoC: json["codigoC"],
        codigoUmbral: json["codigoUmbral"],
        porcentaje: double.parse(json["porcentaje"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "codigoC": codigoC,
        "codigoUmbral": codigoUmbral,
        "porcentaje": porcentaje,
    };
}
