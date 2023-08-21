import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:proyecto_final_prograv/models/dash.dart';
import '../providers/dashboard_service.dart';

class DashboardPage extends StatefulWidget{
  @override 
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>{
  Future<List<Dash>> dash;
  bool _asyncCall = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: _goToCrud,
          icon: Icon(FlutterIcons.server_faw)
          ),
        ],
      ),
      body: _createBody(),
    );
  }
  
 Widget _createBody() {
  dash = DashboardService.getDashboard();
  
  return FutureBuilder(
    future: dash,
    builder: (BuildContext context, AsyncSnapshot<List<Dash>> snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    snapshot.data[index].usuario = ModalRoute.of(context).settings.arguments;
                    await Navigator.pushNamed(context, 'dashboardDetailed', 
                    arguments: snapshot.data[index]);
                  },
                  child: ListTile(
                  tileColor: Colors.lightBlue,
                  title: Center(child: Text(snapshot.data[index].codigo.toString())),
                  subtitle: Center(child: Text(snapshot.data[index].nombre)),
                  ),
                );
              }
        );
      }else{
        return Center( //UN BOTÓN CENTRADO
            child: Text("Cargando monitoreos")
              );
      }
    }
  );
 }

 void _goToCrud() async {
  await Navigator.pushNamed(context, 'tabbedCrud');
 }
}
