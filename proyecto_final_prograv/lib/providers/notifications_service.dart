import 'package:http/http.dart' as http;

class NotificationService{
  static String _baseURL = 
  'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/Notificaciones';

  static Future<bool> notif(int tipo, String usuario, int codigo, int decision) async{
    var url = Uri.parse(_baseURL+"/"+tipo.toString()+"/"+usuario+"/"+codigo.toString()+"/"+decision.toString());
    final response = await http.put(url);
    if(response.statusCode == 204){
      return true;
    }else{
      return false;
    }
  }
}