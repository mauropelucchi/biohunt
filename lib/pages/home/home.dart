import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/pages/tappe/tappa_db.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:biohunt/pages/percorsi/percorso_db.dart';
import 'package:biohunt/pages/home/home_bloc.dart';
import 'package:biohunt/pages/home/side_drawer.dart';
import 'package:biohunt/pages/tappe/tappa_completed/tappa_completed.dart';
import 'package:biohunt/pages/tappe/tappa_widgets.dart';
import 'package:biohunt/utils/keys.dart';


class HomePage extends StatelessWidget {
  final TappaBloc _tappaBloc = TappaBloc(TappaDB.get());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of(context);
    homeBloc.filter.listen((filter) {
      _tappaBloc.updateFilters(filter);
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: Percorso.getFontanella().name,
            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(
                snapshot.data,
                key: ValueKey(HomePageKeys.HOME_TITLE),
              );
            }),
        actions: <Widget>[buildPopupMenu(context)],
        leading: new IconButton(
            icon: new Icon(
              Icons.view_headline,
              key: ValueKey(SideDrawerKeys.DRAWER),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
      ),
      drawer: SideDrawer(),
      body: BlocProvider(
        bloc: _tappaBloc,
        child: GestureDetector(
          key: ValueKey("swipe_home"),
          onHorizontalDragEnd: (details) {
            // Note: Sensitivity is integer used when you don't want to mess up vertical drag
            if (details.velocity.pixelsPerSecond.dx > 1) {
              PercorsoDB.get().getPercorsi().then((list) {
                int currentId =
                    (homeBloc.currentId == null) ? 1 : homeBloc.currentId;
                int nextId = (currentId >= list.length) ? 1 : currentId + 1;
                homeBloc.applyFilter(
                    list[nextId - 1].name, nextId, Filter.byPercorso(nextId));
              });
            } else if (details.velocity.pixelsPerSecond.dx < -1) {
              PercorsoDB.get().getPercorsi().then((list) {
                int currentId =
                    (homeBloc.currentId == null) ? 1 : homeBloc.currentId;
                int nextId = (currentId == 1) ? list.length : currentId - 1;
                homeBloc.applyFilter(
                    list[nextId - 1].name, nextId, Filter.byPercorso(nextId));
              });
            }
          },
          child: TappePage(),
        ),
      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      key: ValueKey(CompletedTappaPageKeys.POPUP_ACTION),
      onSelected: (MenuItem result) async {
        switch (result) {
          case MenuItem.tappaCompleted:
            await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                  builder: (context) => TappaCompletedPage()),
            );
            _tappaBloc.refresh();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
        const PopupMenuItem<MenuItem>(
          value: MenuItem.tappaCompleted,
          child: const Text(
            'Tappe completate',
            key: ValueKey(CompletedTappaPageKeys.COMPLETED_TAPPE),
          ),
        )
      ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { tappaCompleted }
