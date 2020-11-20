import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/home/home_bloc.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:biohunt/pages/percorsi/percorso_bloc.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/utils/keys.dart';

class PercorsoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PercorsoBloc percorsoBloc = BlocProvider.of<PercorsoBloc>(context);
    return StreamBuilder<List<Percorso>>(
      stream: percorsoBloc.percorsi,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PercorsoExpansionTileWidget(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class PercorsoExpansionTileWidget extends StatelessWidget {
  final List<Percorso> _percorsi;

  PercorsoExpansionTileWidget(this._percorsi);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: ValueKey(SideDrawerKeys.DRAWER_PERCORSI),
      leading: Icon(Icons.book),
      title: Text("Percorsi",
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: buildPercorsos(context),
    );
  }

  List<Widget> buildPercorsos(BuildContext context) {
    List<Widget> percorsoWidgetList = List();
    _percorsi.forEach((percorso) => percorsoWidgetList.add(PercorsoRow(percorso)));
    return percorsoWidgetList;
  }
}

class PercorsoRow extends StatelessWidget {
  final Percorso percorso;

  PercorsoRow(this.percorso);

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return ListTile(
      key: ValueKey("tile_${percorso.name}_${percorso.id}"),
      onTap: () {
        homeBloc.applyFilter(percorso.name, percorso.id, Filter.byPercorso(percorso.id));
        Navigator.pop(context);
      },
      leading: Container(
        key: ValueKey("space_${percorso.name}_${percorso.id}"),
        width: 24.0,
        height: 24.0,
      ),
      title: Text(
        percorso.name,
        key: ValueKey("${percorso.name}_${percorso.id}"),
      ),
      trailing: Container(
        height: 10.0,
        width: 10.0,
        child: CircleAvatar(
          key: ValueKey("dot_${percorso.name}_${percorso.id}"),
          backgroundColor: Color(percorso.colorValue),
        ),
      ),
    );
  }
}
