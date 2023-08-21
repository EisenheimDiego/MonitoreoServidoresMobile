import 'package:flutter/material.dart';
import 'package:proyecto_final_prograv/models/dash.dart';
import 'package:proyecto_final_prograv/providers/mail_service.dart';
import 'package:proyecto_final_prograv/providers/notifications_service.dart';

class DashboardDetailedPage extends StatefulWidget {
  @override
  State<DashboardDetailedPage> createState() => DashboardDetailedPageState();
}

class DashboardDetailedPageState extends State<DashboardDetailedPage> {
  DateTime date;
  String state, user;
  num cpu, memory, disk, code;
  List<MonitoreoServicio> services;
  Dash dashResult;

  @override
  Widget build(BuildContext context) {
    dashResult = ModalRoute.of(context).settings.arguments;

    date = dashResult.fecha;
    state = dashResult.estado;
    cpu = dashResult.cpu;
    memory = dashResult.memoria;
    disk = dashResult.disco;
    services = dashResult.monitoreoServicios;
    code = dashResult.codigo;
    user = dashResult.usuario;

    return Scaffold(
        appBar: AppBar(
            title: Text("Detalles del Servidor"),
            centerTitle: true,
            actions: [
              _popMenu(),
              IconButton(onPressed: _sendMail, 
              icon: Icon(Icons.outgoing_mail))
            ]
            ),
        body: _createBody()
        );
  }
  
  Widget _createBody() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
          children: [
            Text("Último monitoreo: "+date.toString()),
            _divider(),
            Text("Estado general: "+state,
              style: TextStyle(color: _colorState(state), 
              fontWeight: state == 'Error' ? FontWeight.bold : FontWeight.normal),
            ),
            _divider(),
            Text("Uso de CPU: "+cpu.toString()),
            _divider(),
            Text("Uso de Memoria: "+memory.toString()),
            _divider(),
            Text("Uso de Disco: "+disk.toString())
          ],
        ),
        )
        ),
    );
  }

  Widget _divider(){
    return Divider(
              thickness: 1.5,
            );
  }
  Widget _popMenu(){
    return PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'services',
                      child: ListTile(
                        leading: Icon(Icons.miscellaneous_services_outlined),
                        title: Text('Servicios'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'on',
                      child: ListTile(
                        leading: Icon(Icons.notifications_on),
                        title: Text('Activar'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'off',
                      child: ListTile(
                        leading: Icon(Icons.notifications_off),
                        title: Text('Desactivar'),
                      ),
                    ),
                  ];
                },
                onSelected: (value) => _selectedValue(value),
              );
  }

  void _selectedValue(String value) async {
    switch (value) {
      case 'services':
        await Navigator.pushNamed(context, 'dashboardDetailedService',
            arguments: services);
        break;
      case 'on':
        _alterNotif(1);
        break;
      case 'off':
        _alterNotif(0);
        break;
    }
  }

  Color _colorState(String state){
    switch (state) {
      case 'Error': return Colors.red;
        break;
      case 'Advertencia': return Colors.yellow;
      default: return Colors.green;
    }
  }

  void _alterNotif(int decision) async {
    var snackBar;
    if (await NotificationService.notif(1, user, code, decision)) {
        snackBar = SnackBar(
        content: Text(decision == 1 
        ? 'Se han activado las notificaciones' 
        : 'Se han desactivado las notificaciones'),
      );
    } else
        snackBar = SnackBar(
        content: Text(decision == 1 
        ? 'No se han activado las notificaciones (ERROR)' 
        : 'No se han desactivado las notificaciones (ERROR)'),
      );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _sendMail() async{
    int statCode = await MailService.sentMails(code);
    var snackBar;
    switch (statCode) {
      case 200: snackBar = SnackBar(content: Text("Correos enviados"),);
        break;
      case 500: snackBar = SnackBar(content: Text("Internal Server Error"),); 
      break;
      default: snackBar = SnackBar(content: Text(statCode.toString()),);
    }
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}