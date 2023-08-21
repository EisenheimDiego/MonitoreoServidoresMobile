import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyecto_final_prograv/models/mail.dart';
import 'package:proyecto_final_prograv/models/server.dart';

class MailService{

  static Map<String, String> routes = {
    'mails':'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/Correo',
    'name':'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/Servidores',
    'sentMail':'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/Procedimientos2Controller/EnvioCorreo'
  };

  static Future<int> sentMails(int code) async{ //ENVIAR CORREOS A ENCARGADOS
    var url = Uri.parse(routes['sentMail']);

    Correo c = new Correo();
    c.nombreServidor = await _serverName(code);
    c.encargados = await _mails(code);

    final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(c.toJson()));
    return response.statusCode;
  }

  static Future<String> _serverName(int code) async{ //NOMBRE DEL SERVIDOR
    var url = Uri.parse(routes['name']+'/'+code.toString());
    final response = await http.get(url);
    if(response.statusCode == 200){
      Servidor servidor = oneServidorFromJson(response.body);
      return servidor.nombre;
    }else{
      return null;
    }
  } 

  static Future<List<String>> _mails(int code) async{ //CORREOS DE LOS ENCARGADOS DEL SERVIDOR
    var url = Uri.parse(routes['mails']+'/'+'1'+'/'+code.toString());
    final response = await http.put(url);
    if(response.statusCode == 200){
      List<dynamic> jsonList = json.decode(response.body);
      List<String> stringList = List<String>.from(jsonList);
      return stringList;
    }else{
      return null;
    }
  }
}