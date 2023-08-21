import 'package:flutter/material.dart';

import '../models/service.dart';
import '../providers/service_service.dart';

class AddService extends StatefulWidget {

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  Servicio servicio = new Servicio();
  int _step = 0;
  TextEditingController _text = new TextEditingController();

  @override
  Widget build(BuildContext context) {

  List<Step> _steps = [
      Step(title: Text('Codigo'), content: _codigo()),
      Step(title: Text('Servidor'), content: _servidor()),
      Step(title: Text('Nombre'), content: _nombre()),
      Step(title: Text('Descripcion'), content: _descripcion()),
      Step(title: Text('Timeout'), content: _timeout()),
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
            Center(child: Text('Agregando servicio'),),
            SizedBox(height: 16.0),
            _steps[_step].content,
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if(_step == 4){
                  _guardarServicio();
                }else{
                  _nextStep();
                }
              },
              child: Text(
                _step < 4 ? 'Siguiente' : 'Registrar',
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
          case 0: servicio.codigoServicio = int.parse(_text.text);
          break;
          case 1: servicio.codigo = int.parse(_text.text);
          break;
          case 2: servicio.nombre = _text.text;
          break;
          case 3: servicio.descripcion = _text.text;
          break;
          case 4: servicio.timeout = double.parse(_text.text);
          break;
      }
      _text.clear();
      _step++;
    });
    }
  }
  
  void _guardarServicio() async {
    servicio.timeout = double.parse(_text.text);
    var snackBar;

    if (await ServiceService().postServicio(servicio)) {
      snackBar = SnackBar(
        content: Text('Se registró el servicio'),
      );
    } else {
      snackBar = SnackBar(
        content: Text('No se registró el servicio'),
      );
    }
    Navigator.pop(context, servicio);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  Widget _codigo() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Código',
        border: OutlineInputBorder(),
      ),
      controller: _text,
    );
  }

  Widget _servidor() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Servidor',
        border: OutlineInputBorder(),
      ),
      controller: _text,
    );
  }

  Widget _nombre() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
      controller: _text,
    );
  }

  Widget _descripcion() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Descripción',
        border: OutlineInputBorder(),
      ),
      controller: _text,
    );
  }

  Widget _timeout() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Timeout',
        border: OutlineInputBorder(),
      ),
      controller: _text,
    );
  }
}