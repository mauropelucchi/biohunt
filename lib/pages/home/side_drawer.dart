import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/pages/percorsi/percorso_db.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:biohunt/pages/about/about_us.dart';
import 'package:biohunt/pages/about/progetto.dart';
import 'package:biohunt/pages/about/kit.dart';
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
            accountName: Text("#CULTURAaiPiediDelCanto"),
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
              backgroundImage: AssetImage("assets/progetto.jpeg"),
            ),
          ),
          ListTile(
              leading: Icon(Icons.question_answer),
              title: Text(
                "Vuoi sapere di più del progetto?",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProgettoScreen(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.build),
              title: Text(
                "Crea il tuo kit",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KitScreen(),
                  ),
                );
              }),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text(
                Percorso.getPercorso1().name,
                key: ValueKey(SideDrawerKeys.PERCORSO1),
              ),
              onTap: () {
                var percorso = Percorso.getPercorso1();
                homeBloc.applyFilter(
                    percorso.name, percorso.id, Filter.byPercorso(percorso.id));
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text(
                Percorso.getPercorso2().name,
                key: ValueKey(SideDrawerKeys.PERCORSO2),
              ),
              onTap: () {
                var percorso = Percorso.getPercorso2();
                homeBloc.applyFilter(
                    percorso.name, percorso.id, Filter.byPercorso(percorso.id));
                Navigator.pop(context);
              }),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text(
                Percorso.getPercorso3().name,
                key: ValueKey(SideDrawerKeys.PERCORSO3),
              ),
              onTap: () {
                var percorso = Percorso.getPercorso3();
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
