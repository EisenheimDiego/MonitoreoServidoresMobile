import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService{
  static String _baseURL = 'https://tiusr5pl.cuc-carrera-ti.ac.cr/APIProyecto/api/ProcedimientosController/Login';

  static Future<bool> logUser(Usuario u) async {
    try {
      var url = Uri.parse(_baseURL);
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(u.toJson()));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}