import 'package:flutter/material.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';
import 'package:biohunt/pages/tappe/row_tappa.dart';
import 'package:biohunt/utils/app_util.dart';

class TappePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TappaBloc _tappeBloc = BlocProvider.of(context);
    return StreamBuilder<List<Tappe>>(
      stream: _tappeBloc.tappe,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildTappaList(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildTappaList(List<Tappe> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: list.length == 0
          ? MessageInCenterWidget("Nessun tappa per questo percorso")
          : Container(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    Color color =
                        (list[index].tappeStatus == TappaStatus.COMPLETE)
                            ? Colors.grey
                            : Colors.green;
                    return Dismissible(
                        key: ValueKey("swipe_${list[index].id}_$index"),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          var lastTappa = list[index].lastTappa;
                          final TappaBloc _tappeBloc =
                              BlocProvider.of<TappaBloc>(context);
                          if (lastTappa) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  //title: const Text("Conferma"),
                                  content: const Text(
                                      "Complimenti! Hai completato il percorso!"),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Ok!")),
                                  ],
                                );
                              },
                            );
                          } else {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return (list[index].tappeStatus ==
                                        TappaStatus.COMPLETE)
                                    ? AlertDialog(
                                        title: const Text("Conferma"),
                                        content: const Text(
                                            "Vuoi rivivere questa tappa?"),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                var tappaID = list[index].id;
                                                _tappeBloc.updateStatus(tappaID,
                                                    TappaStatus.PENDING);
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text(
                                                  "Confermo!")),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("Annulla"),
                                          ),
                                        ],
                                      )
                                    : AlertDialog(
                                        title: const Text("Conferma"),
                                        content: const Text(
                                            "Hai completato questa tappa?"),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                var tappaID = list[index].id;
                                                _tappeBloc.updateStatus(tappaID,
                                                    TappaStatus.COMPLETE);
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text(
                                                  "Tappa completata!")),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("Annulla"),
                                          ),
                                        ],
                                      );
                              },
                            );
                          }
                        },
                        onDismissed: (DismissDirection direction) {},
                        background: Container(),
                        secondaryBackground: Container(
                          color: (list[index].lastTappa ||
                                  list[index].tappeStatus ==
                                      TappaStatus.COMPLETE)
                              ? Colors.grey
                              : Colors.green,
                          child: ListTile(
                            trailing: Icon(
                              (list[index].lastTappa ||
                                      list[index].tappeStatus ==
                                          TappaStatus.COMPLETE)
                                  ? Icons.undo
                                  : Icons.done,
                              //color: Colors.white
                            ),
                          ),
                        ),
                        child: TappaRow(list[index]));
                  }),
            ),
    );
  }
}
