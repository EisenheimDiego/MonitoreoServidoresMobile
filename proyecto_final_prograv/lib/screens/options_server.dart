import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:proyecto_final_prograv/models/component.dart';
import 'package:proyecto_final_prograv/models/server.dart';

import '../providers/server_service.dart';

class OptionsServer extends StatefulWidget{

  @override
  State<OptionsServer> createState() => _OptionsServerState();
}

class _OptionsServerState extends State<OptionsServer> {
  Servidor _selected;
  bool _saving = false;

  TextEditingController _codigoText = new TextEditingController();
  TextEditingController _nombreText = new TextEditingController();
  TextEditingController _descripcionText = new TextEditingController();
  TextEditingController _usuarioAdmin = new TextEditingController();
  TextEditingController _contrasenaText = new TextEditingController();
  TextEditingController _cpuText = new TextEditingController();
  TextEditingController _memoriaText = new TextEditingController();
  TextEditingController _discoText = new TextEditingController();
  TextEditingController _cpuTextE = new TextEditingController();
  TextEditingController _memoriaTextE = new TextEditingController();
  TextEditingController _discoTextE = new TextEditingController();

  bool _isEditable = false;

  bool _once = false;

  double cpuError, cpuWarn, memError, memWarn, diskError, diskWarn;

  List<Componente> _ours;

  @override
  Widget build(BuildContext context) {
    if(!_once){
      final Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _selected = args['server'];
      _ours = args['components'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Servidor"),
        actions: [
          IconButton(onPressed: () => putServer(),
          icon: Icon(Icons.save_as)
          ),
          IconButton(onPressed: () => deleteServer(),
          icon: Icon(Icons.delete)
          ),
        ]
      ),
      body: _createBody()
    );
  }
  
  Widget _createBody() {
    if (!_once) {
      _codigoText.text = _selected.codigo.toString();
      _nombreText.text = _selected.nombre;
      _descripcionText.text = _selected.descripcion;
      _usuarioAdmin.text = _selected.usuarioAdmin;
      _contrasenaText.text = _selected.contrasena;

      _fillComponentes();
    }

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _textCodigo(),
          _divider(),
          _textNombre(),
          _divider(),
          _textDescripcion(),
          _divider(),
          _textAdmin(),
          _divider(),
          _textPass(),
          _divider(),
          _textCPU(),
          _divider(),
          _textMem(),
          _divider(),
          _textDisk()
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 1.5,
    );
  }

  Widget _textCodigo() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Código',
            border: OutlineInputBorder(),
          ),
          controller: _codigoText,
          enabled: false,
        ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
         child: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _isEditable = true;
            });
          },
          )
          )
      ],
    );
  }

  Widget _textNombre() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nombre',
            border: OutlineInputBorder(),
          ),
          controller: _nombreText,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textDescripcion() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Descripción',
            border: OutlineInputBorder(),
          ),
          controller: _descripcionText,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textAdmin() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Usuario admin',
            border: OutlineInputBorder(),
          ),
          controller: _usuarioAdmin,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textPass() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
          ),
          controller: _contrasenaText,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textCPU() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'CPU Advertencia',
            border: OutlineInputBorder(),
          ),
          controller: _cpuText,
          enabled: _isEditable,
        ),
        ),
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'CPU Error',
            border: OutlineInputBorder(),
          ),
          controller: _cpuTextE,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textMem() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Memoria Advertencia',
            border: OutlineInputBorder(),
          ),
          controller: _memoriaText,
          enabled: _isEditable,
        ),
        ),
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Memoria Error',
            border: OutlineInputBorder(),
          ),
          controller: _memoriaTextE,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _textDisk() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Disco Advertencia',
            border: OutlineInputBorder(),
          ),
          controller: _discoText,
          enabled: _isEditable,
        ),
        ),
        Expanded(
            child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Disco Error',
            border: OutlineInputBorder(),
          ),
          controller: _discoTextE,
          enabled: _isEditable,
        ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  void putServer() async {
    var snackBar;

    _selected.nombre = _nombreText.text;
    _selected.descripcion = _descripcionText.text;
    _selected.usuarioAdmin = _usuarioAdmin.text;
    _selected.contrasena = _contrasenaText.text;

    if (await ServerService().putServidor(_selected)) {
      snackBar = SnackBar(
        content: Text('Se ha actualizado el servidor'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, _selected);
    } else {
      snackBar = SnackBar(
          content: Text('No se pudo actualizar el servidor'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void deleteServer() async{
    if(await _showConfirmationDialog(context)){
      var snackBar;
    if(await ServerService().deleteServidor(_selected.codigo)){
      snackBar = SnackBar(
        content: Text('Se ha borrado el servidor'),
      );
    }else{
      snackBar = SnackBar(
        content: Text('No se ha podido borrar el servidor'),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, _selected);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirme el borrado'),
        content: Text('¿Está seguro que desea borrar el servidor?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Sí'),
          ),
        ],
      );
    },
  );
}

  void _fillComponentes(){
    if (_ours.isNotEmpty) {
      cpuWarn = _ours[0].porcentaje;
      cpuError = _ours[1].porcentaje;
      memWarn = _ours[2].porcentaje;
      memError = _ours[3].porcentaje;
      diskWarn = _ours[4].porcentaje;
      diskError = _ours[5].porcentaje;

      _cpuText.text = cpuWarn.toString();
      _memoriaText.text = memWarn.toString();
      _discoText.text = diskWarn.toString();

      _cpuTextE.text = cpuError.toString();
      _memoriaTextE.text = memError.toString();
      _discoTextE.text = diskError.toString();
    }
  }
}