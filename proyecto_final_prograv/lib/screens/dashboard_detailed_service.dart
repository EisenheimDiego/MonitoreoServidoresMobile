import 'package:flutter/material.dart';

import '../models/dash.dart';

class DashBoardDetailedServicePage extends StatefulWidget{
  @override
  State<DashBoardDetailedServicePage> createState() => _DashBoardDetailedServicePageState();
}

class _DashBoardDetailedServicePageState extends State<DashBoardDetailedServicePage> {
  List<MonitoreoServicio> services;
  
  @override
  Widget build(BuildContext context) {
        services = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de Servicios"),
        centerTitle: true,
      ),
      body: _createBody(),
    );
  }
  
  Widget _createBody() {
    return Container(
      child: Center(
        child: DataTable(
          columns: [
            DataColumn(label: Text("Nombre"),),
            DataColumn(label: Text("Estado"),)
          ]
        , rows: rows()
        ),
      )
    );
  }

  List<DataRow> rows(){
    List<DataRow> filas = [];
    for (var element in services) {
      DataRow d = DataRow(cells: [
        DataCell(Text(element.nombre)),
        DataCell(Text(element.estado,
        style: TextStyle(color: element.estado != 'Disponible' 
        ? Colors.red 
        : Colors.green),),)
        ]);
      filas.add(d);
    }
    return filas;
  }
}