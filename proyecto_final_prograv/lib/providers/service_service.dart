import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/service.dart';

class ServiceService {
  static Map<String, String> _routes = {
    'base':'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/Servicios',
    'byServer':'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/ServicioServidor'
  };

  Future<List<Servicio>> getServiciosServer(int server) async {
    var url = Uri.parse(_routes['byServer']+'/'+server.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try{
        return servicioFromJson(response.body);
      }catch(e){
        List<Servicio> servicioBuscado = [];
        servicioBuscado.add(oneServicioFromJson(response.body));
        return servicioBuscado;
      }
    } else {
      return null;
    }
  }

  Future<List<Servicio>> getServicios() async{
    var url = Uri.parse(_routes['base']);
    final response = await http.get(url);

    if(response.statusCode == 200){
      return servicioFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<bool> deleteServicio(int code) async {
    var url = Uri.parse(_routes['base']+'/'+code.toString());
    final response = await http.delete(url);

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> putServicio(Servicio s) async{
    var url = Uri.parse(_routes['base']+'/'+s.codigoServicio.toString());

    final response = await http.put(url,
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    body: jsonEncode(s.toJson()));
    
    if(response.statusCode == 204){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> postServicio(Servicio s) async {
    var url = Uri.parse(_routes['base']);

    final response = await http.post(url,
    headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    body: jsonEncode(s.toJson()));
    
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }
}