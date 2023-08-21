import 'package:flutter/material.dart';

import '../models/user.dart';
import '../providers/user_service.dart';

class LogInPage extends StatefulWidget{
  @override 
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage>{
  bool _iniciando = false;
  final _identificacionController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Text("Inicio de Sesión"),
      ),
      body: Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _identificacionController,
              decoration: InputDecoration(hintText: "Usuario"),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Contraseña"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                _iniciando = true;
              });
              _iniciarSesion();
              },
              child: Text("Iniciar"),
            ),
          ],
        ),
      ),
    ),
    );
  }

  void _iniciarSesion() async {
    var u = Usuario(usuario: _identificacionController.text, contrasena: _passwordController.text);
    if(await UserService.logUser(u)){
      await Navigator.pushNamed(context, 'dashboard', arguments: u.usuario);
    }else{
      final snackBar = SnackBar(
        content: Text('Usuario y/o contraseña incorrectos.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _iniciando = false;
      });
    }
  }
}