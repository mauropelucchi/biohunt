import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';

/// This is the singleton database class which handlers all database transactions
/// All the tappa raw queries is handle here and return a Future<T> with result
class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  //private internal constructor to make it singleton
  AppDatabase._internal();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "tappe.db");
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await _createPercorsoTable(db);
      await _createTappaTable(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute("DROP TABLE ${Tappe.tblTappa}");
      await db.execute("DROP TABLE ${Percorso.tblPercorso}");
      await _createPercorsoTable(db);
      await _createTappaTable(db);
    });
    didInit = true;
  }

  Future _createPercorsoTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Percorso.tblPercorso} ("
          "${Percorso.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Percorso.dbName} TEXT,"
          "${Percorso.dbColorName} TEXT,"
          "${Percorso.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Percorso.tblPercorso}(${Percorso.dbId},${Percorso.dbName},${Percorso.dbColorName},${Percorso.dbColorCode})'
          ' VALUES(1, "La Biofficina del Monte Canto", "Grey", ${Colors.grey.value});');
      txn.rawInsert('INSERT INTO '
          '${Percorso.tblPercorso}(${Percorso.dbId},${Percorso.dbName},${Percorso.dbColorName},${Percorso.dbColorCode})'
          ' VALUES(2, "Pietre e vigneti", "Grey", ${Colors.grey.value});');
      txn.rawInsert('INSERT INTO '
          '${Percorso.tblPercorso}(${Percorso.dbId},${Percorso.dbName},${Percorso.dbColorName},${Percorso.dbColorCode})'
          ' VALUES(3, "Le due Torri", "Grey", ${Colors.grey.value});');
    });
  }

  Future _createTappaTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Tappe.tblTappa} ("
        "${Tappe.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tappe.dbTitle} TEXT,"
        "${Tappe.dbDescription} TEXT,"
        "${Tappe.dbImage} TEXT,"
        "${Tappe.dbLat} DECIMAL,"
        "${Tappe.dbLng} DECIMAL,"
        "${Tappe.dbPercorsoID} LONG,"
        "${Tappe.dbStatus} LONG,"
        "${Tappe.dbLastTappa} BOOLEAN,"
        "FOREIGN KEY(${Tappe.dbPercorsoID}) REFERENCES ${Percorso.tblPercorso}(${Percorso.dbId}) ON DELETE CASCADE);");
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1001, "Partenza (dove parcheggiare)", 45.702771, 9.487119, 1, 0, FALSE,'
          '"Puoi intravedere il frutteto nelle vicinanze della Palestra; puoi lasciare la macchina in uno dei parcheggi disponibili davanti alle case di Via Antonio Gramsci: la prima tappa si trova proprio lì di fronte. Da qui in avanti non avrai più bisogno di indicazioni: basta seguire la strada e fidarsi del proprio istinto di esploratore!",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1002, "Il frutteto", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Cammins .... esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1003, "Area pic-nic", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Ricetta tipica... esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1004, "Attraversando il ponticello", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Pista ciclabile Ciclovia dei Laghi Nord Ovest (verificare).... esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1005, "Il Torrente Grandone", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Lasciando per un attimo la pista ciclabile, sulla destra, puoi scendere per qualche metro e immergerti in una radura selvaggia.... esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1006, "Le asinelle della Biofficina", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Le Asinelle Chicca e Gemma sono le custodi di questo luogo speciale. La Biofficina è sempre aperta: trovi un percorso sensoriale, un piccolo orto e tanto spazio per goderti la natura tutto l’anno! esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1007, "Arrivo_Ponte", 45.703194, 9.486972, 1, 0, FALSE,'
          '"Lo sai che? Da qui puoi arrivare a sotto il monte, paese natale del papa Giovanni esplorazione:",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(1008, "PERCORSO COMPLETATO!", 45.708333, 9.491444, 1, 0, TRUE,'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso1.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2001, "Partenza (dove parcheggiare)", 45.706096, 9.480885, 2, 0, FALSE,'
          '"Lascia la macchina nel parcheggio del Parco Serraglio; prosegui per via Predazzi. Dopo l’azienda Policrom, mantieni la sinistra restando sempre su via Predazzi. Al bivio successivo mantieni la destra e imbocca la mulattiera. In pochi minuti di salita raggiunto la prima tappa.",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2002, "i Mulini", 45.713556, 9.477972, 2, 0, FALSE,'
          '"Lo sai che? Breve storia, perché proprio in quel punto? Torrente? Ruote di pietra nascoste nei boschi\nesplorazione:\nIndicazioni: segui il sentiero che va verso Villa D’Adda (alla tua sinistra) e percorrilo; il sentiero è caratterizzato da muretti a secco su entrambi i lati. Qui inizia la seconda tappa, clicca sul pulsante.",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2003, "Le Pietre", 45.713556, 9.477972, 2, 0, FALSE,'
          '"Lo sai che? Muretti a secco, presente in tutte le culture del pianeta, sempre esistiti nella storia dell’uomo, da poco patrimonio mondiale dell’Unesco nel 2018\nesplorazione: fino a che vedi muretti a secco esplora i sassi e trova oggetti fantastici + riconoscere più oggetti possibili.\mIndicazioni: una volta superati i muretti a secco significa che hai completato anche la seconda tappa! A breve raggiungerai la terza tappa, il lavatoio di Villa d’Adda",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2004, "Il Lavatoio", 45.703194, 9.486972, 2, 0, FALSE,'
          '"Lo sai che? Una volta come si faceva senza lavatrice? I panni si lavavano al lavatoio. Le donne si trovavano, cantavano, ecc... Funzione sociale nei piccoli paesi e nella vita di una volta.\nesplorazione:\nIndicazioni: Dal lavatoio bisogna prendere via Malmetida che prosegue trasformandosi in via per Tassodine. Quando finisce la strada asfaltata, poco prima di una stanga, prendi il sentiero a sinistra che si immette nel vigneto. A questo punto sei pronto per la prossima tappa!",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2005, "Il vigneto", 45.703194, 9.486972, 2, 0, FALSE,'
          '"Lo sai che? Vigneti e uva tradizione breve storia significato vita contadina di una volta (Tassodine nelle vicinanze)\nesplorazione:\nIndicazioni: prosegui sul sentiero e arriverai a destinazione!",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2006, "Arrivo_Località Valle (Villa d’Adda)", 45.717972, 9.471278, 2, 0, FALSE,'
          '"Lo sai che? Le Asinelle Chicca e Gemma sono le custodi di questo luogo speciale. La Biofficina è sempre aperta: trovi un percorso sensoriale, un piccolo orto e tanto spazio per goderti la natura tutto l’anno! esplorazione:",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2007, "Arrivo_Ponte", 45.717972, 9.471278, 2, 0, FALSE,'
          '"Lo sai che? Piccole frazioni, vita di una volta\nesplorazione: Vagare senza meta. Vi trovate all’interno di una frazione dove potete correre il rischio di gironzolare senza perdervi. Cogliete l’occasione per non guardare il navigatore ma lasciarvi guidare dal vostro istinto e da ciò che i vostri occhi vedono.",'
          '"assets/percorso2.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(2008, "PERCORSO COMPLETATO!", 45.717972, 9.471278, 2, 0, TRUE,'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso2.jpeg"'
          ');');
    txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3001, "Partenza (dove parcheggiare)", 45.707604, 9.498688, 3, 0, FALSE,'
          '"Lascia la macchina nel parcheggio della Chiesa Parrocchiale; uscito dal parcheggio segui le indicazioni sulla cartellonista di fronte a te e prendi per Torre San Giovanni. Arrivato nei pressi di Ca’Maitino, prosegui in salita superando la Via Crucis. Giunto in cima alla collina per prima cosa goditi il panorama: hai raggiunto la prima tappa! Da qui in avanti non avrai più bisogno di indicazioni. Resta sempre sul sentiero principale in direzione Fontanella (sentiero n.893) tenendo gli occhi ben aperti sui cartelli e senza farti tentare da bivi o svolte inattese. Puoi anche decidere di deviare e perderti: anche questo fa parte della dura vita dell’esploratore!\nIstruzioni per l’uso: in questo percorso non troverai delle tappe specifiche in cui fermarti (se non la prima tappa e l’arrivo) ma avrai a disposizione tutto il sentiero che si snoda nel bosco per portare a termine 5 esplorazioni. Non è necessario che tu segua l’ordine in cui ti vengono proposte; puoi anche lasciarti ispirare dalla natura che incontri e concluderle in ordine sparso.",'
          '"assets/percorso3.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3002, "Torre di San Giovanni", 45.710000, 9.500556, 3, 0, FALSE,'
          '"Lo sai che? Due info base sulla torre esplorazione:",'
          '"assets/percorso3.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3003, "Il sentiero", 45.713556, 9.477972, 3, 0, FALSE,'
          '"Lo sai che? Quanti sentieri ci sono, km, a piedi in Mountain bike esplorazione 1: esplorazione 2: esplorazione 3: esplorazione 4: esplorazione 5:",'
          '"assets/percorso3.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3004, "Arrivo_Campanile di Fontanella", 45.714750, 9.513528, 3, 0, FALSE,'
          '"Lo sai che? Svetta in mezzo al niente//Torre Abbazia esplorazione:",'
          '"assets/percorso3.jpeg"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbImage})'
          ' VALUES(3005, "PERCORSO COMPLETATO!", 45.714750, 9.513528, 3, 0, TRUE,'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso3.jpeg"'
          ');');

    });
  }
}
