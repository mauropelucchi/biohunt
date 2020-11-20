import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';
import 'package:biohunt/pages/tappe/tappa_db.dart';
import 'package:biohunt/pages/tappe/tappa_completed/row_tappa_completed.dart';

class TappaCompletedPage extends StatelessWidget {
  final TappaBloc _tappaBloc = TappaBloc(TappaDB.get());

  @override
  Widget build(BuildContext context) {
    _tappaBloc.filterByStatus(TappaStatus.COMPLETE);
    return BlocProvider(
      bloc: _tappaBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tappe Completate"),
        ),
        body: StreamBuilder<List<Tappe>>(
            stream: _tappaBloc.tappe,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: ValueKey(
                              "swipe_completed_${snapshot.data[index].id}_$index"),
                          direction: DismissDirection.endToStart,
                          background: Container(),
                          onDismissed: (DismissDirection directions) {
                            if (directions == DismissDirection.endToStart) {
                              var tappaID = snapshot.data[index].id;
                              _tappaBloc.updateStatus(
                                  tappaID, TappaStatus.PENDING);
                              SnackBar snackbar =
                                  SnackBar(content: Text("Annulla"));
                              Scaffold.of(context).showSnackBar(snackbar);
                            }
                          },
                          secondaryBackground: Container(
                            color: Colors.grey,
                            child: ListTile(
                              trailing: Text("Annulla",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          child: TappaCompletedRow(snapshot.data[index]));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
