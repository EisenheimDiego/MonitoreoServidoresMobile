import '../models/dash.dart';
import '../models/server.dart';
import 'package:http/http.dart' as http;

class DashboardService{
  static String _baseURL = 'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/Servidores';

  static Future<List<Servidor>> getServidores() async{
    var url = Uri.parse(_baseURL);
    final response = await http.get(url);
    if(response.statusCode == 200){
      List<Servidor> servidores = servidorFromJson(response.body);
      return servidores;
    }else{
      return null;
    }
  }

  static Future<List<Dash>> getDashboard() async{
    String nuevo = 'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/Dashboard/';
    List<Servidor> servers = await getServidores(); //TODOS LOS SERVERS
    List<Dash> dashboards = [];

    for (var serv in servers) { //PARA CADA SERVER
     var nuevoUrl = Uri.parse(nuevo+serv.codigo.toString());
     final response = await http.get(nuevoUrl);
     if(response.statusCode == 200){ //REVISO SI TIENE UN MONITOREO
       Dash temp = dashFromJson(response.body);
       dashboards.add(temp);
     }else continue;
    }

    return dashboards;
  }
}