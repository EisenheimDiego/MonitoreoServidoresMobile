import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../models/component.dart';
import '../models/server.dart';
import '../models/service.dart';
import '../providers/server_service.dart';
import '../providers/service_service.dart';
import 'add_server.dart';
import 'add_service.dart';

class TabbedCrud extends StatefulWidget {
  @override
  State<TabbedCrud> createState() => _TabbedCrudState();
}

class _TabbedCrudState extends State<TabbedCrud>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future<List<Servidor>> servidores;
  Future<List<Servicio>> servicios;

  int index;
  TextEditingController _searchController = new TextEditingController();

  String searched;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mantenimiento'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(FlutterIcons.server_faw)),
            Tab(icon: Icon(Icons.miscellaneous_services_outlined)),
          ],
        ),
        actions: [
          Container(
            width: 200, // set width here
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
              hintText: index == 1 ? 'Buscar servicio':'Buscar servidor',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) { setState(() {
                searched = value;
              });
              },
            ),
          ),
          IconButton(onPressed: (){},
          icon: Icon(Icons.search)),
        ],
      ),
      body: _createBody(),
    );
  }

  TabBarView _createBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        Container(
          child: Center(
            child: _displayServers(),
          ),
        ),
        Container(
          child: Center(
            child: _displayServices(),
          ),
        ),
      ],
    );
  }

  Widget _displayServers() {
    return StreamBuilder<List<Servidor>>(
      stream: _getServers(),
      builder: (BuildContext context, AsyncSnapshot<List<Servidor>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Servidor s = snapshot.data[index];
                    return ListTile(
                      title: Text(s.codigo.toString()),
                      subtitle: Text(s.nombre),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () => _goServer(snapshot.data[index]),
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddServer();
                  },
                  ),
                tooltip: 'Agregar Server',
                child: Icon(Icons.add),
              ),
            ],
          );
        } else {
          return Text("Cargando servidores");
        }
      },
    );
  }

  Widget _displayServices() {
    return StreamBuilder(
      stream: _getServicios(),
      builder: (BuildContext context, AsyncSnapshot<List<Servicio>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Servicio s = snapshot.data[index];
                  return ListTile(
                    title: Text(s.codigoServicio.toString()),
                    subtitle: Text(s.nombre),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () => _goService(snapshot.data[index]),
                  );
                },
              )
              ),
              FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddService();
                  },
                  ),
                tooltip: 'Agregar Servicio',
                child: Icon(Icons.add),
              ),
            ],
          );
        } else {
          return Text("Cargando servicio");
        }
      },
    );
  }

  
  Stream<List<Servidor>> _getServers() {
    if(searched == null || searched.isEmpty)
      servidores = ServerService().getServidores();
    else
    if(index != 1)
      servidores = ServerService().getServidoresNombre(searched);
    return servidores.asStream();
  }

  Stream<List<Servicio>> _getServicios() {
    if(searched == null || searched.isEmpty)
      servicios = ServiceService().getServicios();
    else
      if(index == 1)
      try{ servicios = ServiceService().getServiciosServer(int.parse(searched));}
      catch(e){print(e);}
    return servicios.asStream();
  }

  void _goServer(Servidor s) async{
    List<Componente> ours = await ServerService().getComponentes(s.codigo);
    final result = await Navigator.pushNamed(context, 'optionsServer', arguments: {
      'server': s,
      'components':ours
    });

    if(result != null){
      setState(() {
        _getServers();
      });
    }
  }

  void _goService(Servicio s) async {
    final result = await Navigator.pushNamed(context, 'optionsService', arguments: s);
    if(result != null){
      setState(() {
        _getServicios();
      });
    }
  }
}
