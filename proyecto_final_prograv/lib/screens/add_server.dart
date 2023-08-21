import 'package:flutter/material.dart';

import '../models/server.dart';
import '../providers/server_service.dart';

class AddServer extends StatefulWidget {

  @override
  State<AddServer> createState() => _AddServerState();
}

class _AddServerState extends State<AddServer> {
  Servidor servidor = new Servidor();
  int _step = 0;
  TextEditingController _text = new TextEditingController();

  @override
  Widget build(BuildContext context) {

  List<Step> _steps = [
    Step(title: Text('Codigo'), content: codigo()),
    Step(title: Text('Nombre'), content: _nombre()),
    Step(title: Text('Descripcion'), content: _descripcion()),
    Step(title: Text('Usuario Admin'), content: _usuario()),
    Step(title: Text('Contraseña'), content: _pass()),
    Step(title: Text('CPU'), content: _cpu()),
    Step(title: Text('CPU'), content: _cpuMax()),
    Step(title: Text('Memoria'), content: _memoria()),
    Step(title: Text('Memoria'), content: _memoriaMax()),
    Step(title: Text('Disco'), content: _disco()),
    Step(title: Text('Disco'), content: _discoMax()),
  ];

    return Dialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('Agregando servidor'),),
            SizedBox(height: 16.0),
            _steps[_step].content,
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if(_step == 10){
                  _guardarServer();
                }else{
                  _nextStep();
                }
              },
              child: Text(
                _step < 10 ? 'Siguiente' : 'Registrar',
              ),
            ),
          ]
        )
    )
    );
  }

  void _nextStep() {
    if(_text.text.isNotEmpty){
      setState(() {
      switch (_step) {
          case 0: servidor.codigo = int.parse(_text.text);
          break;
          case 1: servidor.nombre = _text.text;
          break;
          case 2: servidor.descripcion = _text.text;
          break;
          case 3: servidor.usuarioAdmin = _text.text;
          break;
          case 4: servidor.contrasena = _text.text;
          break;
          case 5: servidor.cpuMin = double.parse(_text.text);
          break;
          case 6: servidor.cpuMax = double.parse(_text.text);
          break;
          case 7: servidor.memMin = double.parse(_text.text);
          break;
          case 8: servidor.memMax = double.parse(_text.text);
          break;
          case 9: servidor.discoMin = double.parse(_text.text);
          break;
          case 10: servidor.discoMax = double.parse(_text.text);
          break;
      }
      _text.clear();
      _step++;
    });
    }
  }
  
  void _guardarServer() async {
    servidor.discoMax = double.parse(_text.text);
    var snackBar;

    if (await ServerService().postServidor(servidor)) {
      snackBar = SnackBar(
        content: Text('Se registró el servidor'),
      );
    } else {
      snackBar = SnackBar(
        content: Text('No se registró el servidor'),
      );
    }
    Navigator.pop(context, servidor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      _step = 0;
    });
  }

  Widget codigo(){
    return TextField(decoration: InputDecoration(labelText: 'Código',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _nombre(){
    return TextField(decoration: InputDecoration(labelText: 'Nombre',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _descripcion(){
    return TextField(decoration: InputDecoration(labelText: 'Descripción',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _usuario(){
    return TextField(decoration: InputDecoration(labelText: 'Usuario',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _pass(){
    return TextField(decoration: InputDecoration(labelText: 'Contraseña',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _cpu(){
    return TextField(decoration: InputDecoration(labelText: 'CPU Advertencia',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _cpuMax(){
    return TextField(decoration: InputDecoration(labelText: 'CPU Error',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _memoria(){
    return TextField(decoration: InputDecoration(labelText: 'Memoria Advertencia',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _memoriaMax(){
    return TextField(decoration: InputDecoration(labelText: 'Memoria Error',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _disco(){
    return TextField(decoration: InputDecoration(labelText: 'Disco Advertencia',
            border: OutlineInputBorder(),), controller: _text,);
  }

  Widget _discoMax(){
    return TextField(decoration: InputDecoration(labelText: 'Disco Error',
            border: OutlineInputBorder(),), controller: _text,);
  }
}