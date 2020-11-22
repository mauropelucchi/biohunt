import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/pages/percorsi/percorso_db.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:biohunt/pages/about/about_us.dart';
import 'package:biohunt/pages/home/home_bloc.dart';
import 'package:biohunt/pages/percorsi/percorso_bloc.dart';
import 'package:biohunt/pages/percorsi/percorso_widget.dart';
import 'package:biohunt/utils/keys.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("#CulturaAiPiediDelCanto"),
            accountEmail: Text("associazionelumacaribelle@gmail.com"),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/montecanto.jpg"),
            ),
          ),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text(
                "Fontanella",
                key: ValueKey(SideDrawerKeys.FONTANELLA),
              ),
              onTap: () {
                var percorso = Percorso.getFontanella();
                homeBloc.applyFilter(
                    percorso.name, percorso.id, Filter.byPercorso(percorso.id));
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text(
                "San Giovanni",
                key: ValueKey(SideDrawerKeys.SANGIOVANNI),
              ),
              onTap: () {
                var percorso = Percorso.getSanGiovanni();
                homeBloc.applyFilter(
                    percorso.name, percorso.id, Filter.byPercorso(percorso.id));
                Navigator.pop(context);
              }),
          BlocProvider(
            bloc: PercorsoBloc(PercorsoDB.get()),
            child: PercorsoPage(),
          ),
        ],
      ),
    );
  }
}
