import 'package:biohunt/db/app_db.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:sqflite/sqflite.dart';

class TappaDB {
  static final TappaDB _tappaDb = TappaDB._internal(AppDatabase.get());

  AppDatabase _appDatabase;

  //private internal constructor to make it singleton
  TappaDB._internal(this._appDatabase);

  //static TappaDB get tappaDb => _tappaDb;

  static TappaDB get() {
    return _tappaDb;
  }

  Future<List<Tappe>> getTappe(
      {TappaStatus tappaStatus}) async {
    var db = await _appDatabase.getDb();
    var whereClause = "";
    if (tappaStatus != null) {
      var tappaWhereClause =
          "${Tappe.tblTappa}.${Tappe.dbStatus} = ${tappaStatus.index}";
      whereClause = "WHERE $tappaWhereClause";
    }

    var result = await db.rawQuery(
        'SELECT ${Tappe.tblTappa}.*,${Percorso.tblPercorso}.${Percorso.dbName},${Percorso.tblPercorso}.${Percorso.dbColorCode} '
        'FROM ${Tappe.tblTappa} '
        'INNER JOIN ${Percorso.tblPercorso} ON ${Tappe.tblTappa}.${Tappe.dbPercorsoID} = ${Percorso.tblPercorso}.${Percorso.dbId} $whereClause GROUP BY ${Tappe.tblTappa}.${Tappe.dbId} ORDER BY ${Tappe.tblTappa}.${Tappe.dbId} ASC;');

    return _bindData(result);
  }

  List<Tappe> _bindData(List<Map<String, dynamic>> result) {
    List<Tappe> tappe = List();
    for (Map<String, dynamic> item in result) {
      var myTappa = Tappe.fromMap(item);
      myTappa.percorsoName = item[Percorso.dbName];
      myTappa.percorsoColor = item[Percorso.dbColorCode];
      tappe.add(myTappa);
    }
    return tappe;
  }

  Future<List<Tappe>> getTappeByPercorso(int percorsoId,
      {TappaStatus status}) async {
    var db = await _appDatabase.getDb();
    String whereStatus = status != null
        ? "AND ${Tappe.tblTappa}.${Tappe.dbStatus}=${status.index}"
        : "";
    var result = await db.rawQuery(
        'SELECT ${Tappe.tblTappa}.*,${Percorso.tblPercorso}.${Percorso.dbName},${Percorso.tblPercorso}.${Percorso.dbColorCode} '
        'FROM ${Tappe.tblTappa} '
        'INNER JOIN ${Percorso.tblPercorso} ON ${Tappe.tblTappa}.${Tappe.dbPercorsoID} = ${Percorso.tblPercorso}.${Percorso.dbId} WHERE ${Tappe.tblTappa}.${Tappe.dbPercorsoID}=$percorsoId $whereStatus GROUP BY ${Tappe.tblTappa}.${Tappe.dbId} ORDER BY ${Tappe.tblTappa}.${Tappe.dbId} ASC;');
    return _bindData(result);
  }


  Future updateTappaStatus(int tappaID, TappaStatus status) async {
    var db = await _appDatabase.getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tappe.tblTappa} SET ${Tappe.dbStatus} = '${status.index}' WHERE ${Tappe.dbId} = '$tappaID'");
    });
  }


}
