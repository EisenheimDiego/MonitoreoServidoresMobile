import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../models/service.dart';
import '../providers/service_service.dart';

class OptionsService extends StatefulWidget {
  @override
  State<OptionsService> createState() => _OptionsServiceState();
}

class _OptionsServiceState extends State<OptionsService> {
  Servicio _selected;
  bool _saving = false;

  TextEditingController _codigoServicioText = new TextEditingController();
  TextEditingController _codigoText = new TextEditingController();
  TextEditingController _nombreText = new TextEditingController();
  TextEditingController _descripcionText = new TextEditingController();
  TextEditingController _timeoutText = new TextEditingController();

  bool _isEditable = false;

  bool _once = false;

  @override
  Widget build(BuildContext context) {
    if(!_once){
      _selected = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
        appBar: AppBar(title: Text("Servicio"), actions: [
          IconButton(onPressed: () => putServicio(),
          icon: Icon(Icons.save_as)
          ),
          IconButton(onPressed: () => deleteServicio(),
          icon: Icon(Icons.delete)
          ),
        ]),
        body: _createBody());
  }

  Widget _createBody() {
    if (!_once) {
      _codigoText.text = _selected.codigo.toString();
      _nombreText.text = _selected.nombre;
      _descripcionText.text = _selected.descripcion;
      _codigoServicioText.text = _selected.codigoServicio.toString();
      _timeoutText.text = _selected.timeout.toString();
      _once = true;
    }

    return ModalProgressHUD(
      inAsyncCall: _saving,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _textCodigoS(),
          _divider(),
          _textNombre(),
          _divider(),
          _textCodigo(),
          _divider(),
          _textDesc(),
          _divider(),
          _textTimeout()
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      thickness: 1.5,
    );
  }

  Widget _textCodigoS() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Código',
              border: OutlineInputBorder(),
            ),
            controller: _codigoServicioText,
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

  Widget _textCodigo() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Servidor',
              border: OutlineInputBorder(),
            ),
            controller: _codigoText,
            enabled: _isEditable,
          ),
        ),
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
      ],
    );
  }

  Widget _textDesc() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Descripcion',
              border: OutlineInputBorder(),
            ),
            controller: _descripcionText,
            enabled: _isEditable,
          ),
        ),
      ],
    );
  }

  Widget _textTimeout() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Timeout',
              border: OutlineInputBorder(),
            ),
            controller: _timeoutText,
            enabled: _isEditable,
          ),
        ),
      ],
    );
  }

  void putServicio() async {

    _selected.codigo = int.parse(_codigoText.text);
    _selected.nombre = _nombreText.text;
    _selected.descripcion = _descripcionText.text;
    _selected.timeout = double.parse(_timeoutText.text);

    var snackBar;

    if (await ServiceService().putServicio(_selected)) {
      snackBar = SnackBar(
        content: Text('Se ha actualizado el servicio'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, _selected);
    } else {
      snackBar = SnackBar(content: Text('No se pudo actualizar el servicio'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirme el borrado'),
        content: Text('¿Está seguro que desea borrar el servicio?'),
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

  void deleteServicio() async{
    if (await _showConfirmationDialog(context)) {
      var snackBar;
      if (await ServiceService().deleteServicio(_selected.codigoServicio)) {
        snackBar = SnackBar(
          content: Text('Se ha borrado el servicio'),
        );
      } else {
        snackBar = SnackBar(
          content: Text('No se ha podido borrar el servicio'),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, _selected);
    }
  }
}
