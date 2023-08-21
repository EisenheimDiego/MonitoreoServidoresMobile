import 'dart:convert';

import '../models/component.dart';
import '../models/server.dart';
import 'package:http/http.dart' as http;

class ServerService {
  static Map<String, String> _routes = {
    'base': 'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/Servidores',
    'byName':
        'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/ServidorNombre',
    'components':
        'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/UmbralComponentes'
  };

  Future<List<Servidor>> getServidoresNombre(String nombre) async {
    var url = Uri.parse(_routes['byName'] + '/' + nombre);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return servidorFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<Servidor>> getServidores() async {
    var url = Uri.parse(_routes['base']);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return servidorFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> postServidor(Servidor s) async {
    var url = Uri.parse(_routes['base']);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(s.toJson()));

    if (response.statusCode == 201) {
      //POSTEADO EL SERVER

      var newUrl = Uri.parse(_routes['components']);
      Componente c = new Componente();
      c.codigo = s.codigo;
      c.codigoC = 1; //cpu
      c.codigoUmbral = 1; //adv
      c.porcentaje = s.cpuMin;

      var newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADO EL CPU-ADVERT

      c.codigoC = 1; //cpu
      c.codigoUmbral = 2; //adv
      c.porcentaje = s.cpuMax;

      newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADO EL CPU ERROR

      c.codigoC = 2; //cpu
      c.codigoUmbral = 1; //adv
      c.porcentaje = s.memMin;

      newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADO LA MEM ADV

      c.codigoC = 2; //cpu
      c.codigoUmbral = 2; //adv
      c.porcentaje = s.memMax;

      newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADO LA MEM ERR

      c.codigoC = 3; //cpu
      c.codigoUmbral = 1; //adv
      c.porcentaje = s.discoMin;

      newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADA EL DISC ADV

      c.codigoC = 3; //cpu
      c.codigoUmbral = 2; //adv
      c.porcentaje = s.discoMax;

      newResp = await http.post(newUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
      if (newResp.statusCode != 201) {
        return false;
      }
      //POSTEADA EL DISC ERR

      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteServidor(int code) async {
    var url = Uri.parse(_routes['base']+'/'+code.toString());
    final response = await http.delete(url);

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> putServidor(Servidor s) async {
    var url = Uri.parse(_routes['base']+'/'+s.codigo.toString());
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

  Future<List<Componente>> getComponentes(int code) async{
    var url = Uri.parse(_routes['components']);
    final response = await http.get(url);

    if(response.statusCode == 200){
      List<Componente> todos = componenteFromJson(response.body);
      List<Componente> buscados = todos.where((element) => element.codigo == code).toList();
      return buscados;
    }else{
      return null;
    }
  }
}