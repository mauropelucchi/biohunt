import 'package:biohunt/db/app_db.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';

class PercorsoDB {
  static final PercorsoDB _percorsoDb = PercorsoDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  PercorsoDB._internal(this._appDatabase);

  static PercorsoDB get() {
    return _percorsoDb;
  }

  Future<List<Percorso>> getPercorsi() async {
    var db = await _appDatabase.getDb();
    var result =
        await db.rawQuery('SELECT * FROM ${Percorso.tblPercorso}');
    List<Percorso> percorsi = List();
    for (Map<String, dynamic> item in result) {
      var myPercorso = Percorso.fromMap(item);
      percorsi.add(myPercorso);
    }
    return percorsi;
  }


}
