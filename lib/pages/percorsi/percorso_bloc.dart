import 'dart:async';

import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/percorsi/percorso_db.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';

class PercorsoBloc implements BlocBase {
  StreamController<List<Percorso>> _percorsoController =
      StreamController<List<Percorso>>.broadcast();

  Stream<List<Percorso>> get percorsi => _percorsoController.stream;

  PercorsoDB _percorsoDB;

  PercorsoBloc(this._percorsoDB) {
    _loadPercorsos();
  }

  @override
  void dispose() {
    _percorsoController.close();
  }

  void _loadPercorsos() {
    _percorsoDB.getPercorsi().then((percorsi) {
      _percorsoController.sink.add(percorsi);
    });
  }

  void refresh(){
    _loadPercorsos();
  }
}
