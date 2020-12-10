import 'dart:async';
import 'package:flutter/material.dart';
import 'package:biohunt/pages/percorsi/percorso.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
      String path = join(await getDatabasesPath(), "tappe.db");
      _database = await openDatabase(path, version: 2,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await _createPercorsoTable(db);
        await _createTappaTable(db);
        didInit = true;
      }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await _clean(db);
        await _createPercorsoTable(db);
        await _createTappaTable(db);
        didInit = true;
      });
  }

  Future _clean(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("DROP TABLE ${Tappe.tblTappa}");
      txn.execute("DROP TABLE ${Percorso.tblPercorso}");
    });
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
          "${Tappe.dbIndicazioni} TEXT,"
          "${Tappe.dbEsplorazione} TEXT,"
          "${Tappe.dbTitleEsplorazione} TEXT,"
          "${Tappe.dbImage} TEXT,"
          "${Tappe.dbLat} REAL,"
          "${Tappe.dbLng} REAL,"
          "${Tappe.dbPercorsoID} INTEGER,"
          "${Tappe.dbStatus} INTEGER,"
          "${Tappe.dbLastTappa} INTEGER,"
          "FOREIGN KEY(${Tappe.dbPercorsoID}) REFERENCES ${Percorso.tblPercorso}(${Percorso.dbId}) ON DELETE CASCADE);");
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1001, "Partenza (dove parcheggiare)", 45.702771, 9.487119, 1, 0, 0,'
          '"", "",'
          '"Nelle vicinanze della palestra puoi intravedere un frutteto; puoi lasciare la macchina in uno dei parcheggi disponibili davanti alle case di via Antonio Gramsci: la prima tappa si trova proprio lì di fronte. Da qui in avanti basta seguire la pista ciclabile, leggere le indicazioni e fidarti del tuo istinto di esploratore.",'
          '"assets/percorso1/1.jpg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1002, "Il frutteto", 45.703194, 9.486972, 1, 0, 0,'
          '"Nel 2015 il Comune di Carvico, in collaborazione con l’Associazione Camminiamo Insieme Onlus e Agenda21 Isola Dalmine-Zingonia, ha destinato questa grande area verde a frutteto sociale, un’opportunità per la comunità di prendersi cura del proprio territorio.",'
          '"",'
          '"Sfumature di colore: stai fermo in un posto per qualche minuto, guardati intorno e conta tutti i colori che riesci a trovare. E quante sfumature dello stesso colore riesci a vedere?",'
          '"assets/percorso1/2.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1003, "Area pic-nic", 45.703713, 9.488836, 1, 0, 0,'
          '"Parlando di pic-nic, come non pensare a un piatto tipico come la polenta? Dovete sapere che ai piedi del Monte Canto e in tutto il territorio dell’Isola Bergamasca si coltiva il Nostrano, una delle più note varietà locali di mais da polenta. Questo mais giallo è stato introdotto più di cento anni fa e viene coltivato ancora oggi da alcune aziende agricole locali.",'
          '"",'
          '"Scrittura naturale: crea degli strumenti di scrittura con le cose che trovi in natura (bastoni, aghi di pino, ciuffi d’erba); prova a creare anche un inchiostro utilizzando materiale naturale. Usali per fare un disegno su un foglio bianco o sul tuo quaderno degli appunti.",'
          '"assets/percorso1/3.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1004, "Attraversando il ponticello", 45.703952, 9.489376, 1, 0, 0,'
          '"La pista ciclabile che stai percorrendo parte dal Comune di Sotto il Monte Giovanni XXIII e, passando per Carvico, arriva alla stazione dei treni di Calusco. Da qui, nei pressi del ponte di ferro, puoi raggiungere in un attimo il Fiume Adda e la sua ciclabile.",'
          '"Torna indietro e segui la pista ciclabile sterrata.",'
          '"Mappa dei suoni: siediti in un luogo per circa 5 minuti. Prendi un foglio e segna una “X” al centro: quello è il punto in cui ti sei seduto. Quando senti un rumore prova a rappresentarlo sul foglio, indicando la direzione da cui lo senti arrivare. Puoi scrivere il nome dell’oggetto che crea il rumore (es. martello), il rumore che fa (es. tum tum) oppure disegnarlo in modo molto semplice. Se possibile, chiudi gli occhi mentre ascolti.",'
          '"assets/percorso1/4.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1005, "Il Torrente Grandone", 45.705604, 9.490716, 1, 0, 0,'
          '"Lasciando per un attimo la pista ciclabile, sulla destra, puoi scendere per qualche metro e immergerti nel sottobosco selvatico che segue il flusso di questo torrente che nasce sul Monte Canto. Nelle giornate piovose, munito di stivali, puoi vivere un’esperienza da vero esploratore della natura!",'
          '"",'
          '"Piccoli ecosistemi crescono: prendi un barattolo e preleva un po’ di acqua dal torrente. Potrai aggiungere altra acqua presa altrove (es. uno stagno o una pozzanghera). Chiudi bene il coperchio, porta a casa il barattolo e mettilo al sole. Ben presto si formerà un piccolo mondo, un ecosistema che inizierà ad auto-organizzarsi. Osserva ogni giorno i cambiamenti che avvengono nel barattolo.",'
          '"assets/percorso1/5.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1006, "Le asinelle della Biofficina", 45.706778, 9.491921, 1, 0, 0,'
          '"Le Asinelle Chicca e Gemma sono le custodi di questo luogo speciale. La Biofficina è sempre aperta: trovi un percorso sensoriale, un piccolo orto e tanto spazio per goderti la natura tutto l’anno!",'
          '"",'
          '"La cornice magica: crea una cornice utilizzando dei rami o dei bastoni. Riempila con materiali naturali di diversi colori e forme, formando un quadro. Fai un passo indietro e ammira la tua opera.",'
          '"assets/percorso1.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1007, "Arrivo Ponte", 45.707994, 9.491417, 1, 0, 0,'
          '"Continuando a seguire la strada, in pochi minuti puoi raggiungere il Comune di Sotto il Monte, paese natale di Papa Giovanni XXIII; qui è possibile visitare la sua casa e altri luoghi importanti legati alla sua infanzia.",'
          '"",'
          '"Un messaggio inatteso: ritaglia o strappa una striscia di carta da un foglio bianco. Scrivi un tuo desiderio, oppure un augurio o un messaggio positivo e appendilo alla staccionata con uno spago (non scrivere sulla staccionata!!)",'
          '"assets/percorso1/6.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(1008, "PERCORSO COMPLETATO!", 45.707994, 9.491417, 1, 0, 1,'
          '"",'
          '"",'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso1.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2001, "Partenza (dove parcheggiare)", 45.706096, 9.480885, 2, 0, 0,'
          '"",'
          '"Lascia la macchina nel parcheggio del Parco Serraglio; prosegui per via Predazzi. Dopo l’azienda Policrom, mantieni la sinistra restando sempre su via Predazzi. Al bivio successivo mantieni la destra e imbocca la mulattiera. In pochi minuti di salita avrai raggiunto la prima tappa.",'
          '"",'
          '"assets/percorso2/1.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2002, "I Mulini", 45.713556, 9.477972, 2, 0, 0,'
          '"Il nome di questa frazione non è casuale. Non per niente nei boschi del Monte Canto potresti incontrare delle antiche ruote di pietra, identificabili con delle macine. Ricoperte dal muschio, osservale da vicino e prova a immaginare come dovevano essere questi luoghi tantissimi anni fa.",'
          '"Segui il sentiero che va verso Villa D’Adda (alla tua sinistra) e percorrilo; il sentiero è caratterizzato da muretti a secco su entrambi i lati. Qui inizia la seconda tappa, clicca sul pulsante.",'
          '"Il tuo posto magico: osserva il sentiero che prosegue verso l’alto, immagina un mondo magico appena dietro l’angolo. Poniti delle domande che ti aiutino a crearlo utilizzando la tua fantasia (e se dietro la curva vivessero degli elfi? E se in quel luogo gli alberi fossero tutti blu, o viola? E se ci fosse un paese formato solo da case sugli alberi?). Opzionale: disegnalo su un foglio.",'
          '"assets/percorso2/2.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2003, "Le Pietre", 45.713946, 9.477044, 2, 0, 0,'
          '"La dura pietra, i sassi, sono profondamente legati alla storia del Monte Canto, dove vi è ancora traccia di due antiche cave di pietra. Dal 2018 i muretti a secco, costruzioni presenti in tutte le culture del pianeta e nella storia dell’uomo, sono stati riconosciuti patrimonio mondiale dell’Unesco.",'
          '"Una volta superati i muretti a secco significa che hai completato anche la seconda tappa! A breve raggiungerai la terza tappa, il lavatoio di Villa d’Adda.",'
          '"Storie di pietra: cerca quanti più tipi possibili di pietre, toccale (attento a non disturbare gli abitanti che stanno riposando al loro interno!), osservale con la lente (se ce l’hai), senti la loro consistenza: cos’hanno di diverso tra loro? Divertiti a cercare qualche pietra che ti ricordi altri oggetti.",'
          '"assets/percorso2/3.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2004, "Il Lavatoio", 45.714658, 9.472404, 2, 0, 0,'
          '"Come si faceva una volta senza lavatrice? I panni si lavavano al lavatoio. Questi manufatti in pietra, spesso ricavati da antichi sarcofagi, venivano collocati nelle zone centrali dei paesini. Qui le donne si trovavano per lavare i panni, cantare, chiacchierare, connotandoli come luoghi importanti di socialità.",'
          '"Dal lavatoio bisogna prendere via Malmetida che prosegue trasformandosi in via per Tassodine. Quando finisce la strada asfaltata, poco prima di una stanga, prendi il sentiero a sinistra che si immette nel vigneto. A questo punto sei pronto per la prossima tappa!",'
          '"La forma dell’acqua: osserva la vasca del lavatoio e scopri quante forme può creare l’acqua. Trova tutte quelle che riesci. Usa un bastoncino per crearne di nuove. Anche il grande Leonardo Da Vinci fece studi approfonditi sull’acqua e le sue forme: questa esplorazione gli sarebbe sicuramente piaciuta.",'
          '"assets/percorso2/4.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2005, "Il vigneto", 45.703194, 9.486972, 2, 0, 0,'
          '"La traccia più antica di questa lavorazione della terra la troviamo nella Bibbia: nell’antico testamento si parla infatti di Noè che piantò un vigneto sul Monte Ararat e con il vino prodotto si ubriacò. Il territorio di Villa D’Adda, sul versante sud del monte Canto e in posizione collinare, è particolarmente adatto alla coltivazione della vite; in particolare potete ammirare il magnifico vigneto dell’Azienda Agricola Tassodine, circondato da boschi di castagni, robinia, ciliegi e querce secolari.",'
          '"Prosegui sul sentiero e arriverai a destinazione!",'
          '"Il mio museo naturale: colleziona diversi oggetti naturali in base a queste caratteristiche: 6 oggetti piccolissimi, 5 foglie di diversa forma, 4 sassi di colori differenti, 3 rametti curvi, 2 oggetti morbidi, 1 oggetto (ramo, sasso, foglia...) che assomiglia a un animale.",'
          '"assets/percorso2/5.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2006, "Arrivo Località Valle (Villa d’Adda)", 45.717972, 9.471278, 2, 0, 0,'
          '"I paesi ai piedi del Monte Canto sono ricchi di piccole frazioni, istantanee di vita di una volta, collegate tra loro da un reticolo di mulattiere.",'
          '"",'
          '"Vagare senza meta: ti trovi all’interno di una piccola frazione dove puoi correre il rischio di gironzolare senza perderti. Cogli l’occasione per non guardare il navigatore: lasciati guidare dal tuo istinto e da ciò che vedono i tuoi occhi. Osserva con attenzione le piccole cose. Vaga per 10/15 minuti: alla fine scrivi sette dettagli che ti hanno incuriosito.",'
          '"assets/percorso2/6.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(2007, "PERCORSO COMPLETATO!", 45.717972, 9.471278, 2, 0, 1,'
          '"",'
          '"",'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso2.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3001, "Partenza (dove parcheggiare)", 45.707604, 9.498688, 3, 0, 0,'
          '"",'
          '"Lascia la macchina nel parcheggio della Chiesa Parrocchiale; uscito dal parcheggio segui le indicazioni sulla cartellonistica di fronte a te e prendi per Torre San Giovanni. Arrivato nei pressi di Ca’ Maitino, prosegui in salita superando la Via Crucis. Giunto in cima alla collina per prima cosa goditi il panorama: hai raggiunto la prima tappa! Da qui in avanti non avrai più bisogno di indicazioni. Resta sempre sul sentiero principale in direzione Fontanella (sentiero n.893) tenendo gli occhi ben aperti sui cartelli e senza farti tentare da bivi o svolte inattese. Puoi anche decidere di deviare e perderti: anche questo fa parte della dura vita dell’esploratore!",'
          '"Istruzioni per l’uso: in questo percorso non troverai delle tappe specifiche in cui fermarti (se non la prima tappa e l’arrivo, ciascuna con la propria esplorazione) ma avrai a disposizione tutto il sentiero che si snoda nel bosco per portare a termine 5 esplorazioni. Non è necessario che tu segua l’ordine in cui ti vengono proposte; puoi anche lasciarti ispirare dalla natura che incontri e concluderle in ordine sparso.",'
          '"assets/percorso3/1.png"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3002, "Torre di San Giovanni", 45.710000, 9.500556, 3, 0, 0,'
          '"La torre di S. Giovanni, una torre campanaria in stile romanico, era in origine una piccola fortezza costruita nel 964 sulla cima del colle ai piedi del Monte Canto. È alta ben 17 metri e proprio qui accanto fu costruita, nel 1356, la prima Chiesa Parrocchiale di Sotto il Monte, poi abbattuta all’inizio del novecento per essere ricostruita in una zona più accessibile.",'
          '"",'
          '"Siedi e ammira: impara a fermarti 5 minuti senza fare niente per godere di ciò che ti circonda. Osserva il panorama e trova due località che visiterai presto.",'
          '"assets/percorso3/2.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3003, "Il sentiero", 45.710000, 9.500556, 3, 0, 0,'
          '"Il Monte Canto è ricco di itinerari percorribili a piedi e in bicicletta. Da ognuno dei centri abitati che lo circondano partono sentieri che lo attraversano in tutta la sua bellezza e diversità, tra boschi, castagneti e vigneti. Il Monte Canto, proprio per questa ricchezza, ospita da anni la famosa gara Sky del Canto.",'
          '"",'
          '"",'
          '"assets/percorso3/3.jpeg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3004, "Le 5 esplorazioni del sentiero", 45.713556, 9.477972, 3, 0, 0,'
          '"",'
          '"",'
          '"Crea un piccolo oggetto artistico con materiale naturale: nascondilo e poi crea dei segnali sul terreno per ritrovarlo, utilizzando bastoni, foglie o altri sassolini.|Trova e documenta facce, volti o personaggi mentre cammini nel bosco. Cercali nelle radici, tra i sassi, tra i rami degli alberi, nelle nuvole, ecc.|Esiste un richiamo particolare per attirare vicino gli uccelli del bosco: consiste in un semplice “pssh” ripetuto lentamente e in modo regolare tre o quattro volte. Ripeti la serie per alcune volte e poi fermati a osservare e ascoltare se qualche uccellino si è avvicinato. Usa il richiamo solo se sei sicuro di non disturbare uccelli che stanno facendo il nido.|Raccogli tutto il materiale che riesci per costruire una o più micro-capanne nel bosco. Scegli un posto che sia visibile anche dal sentiero, in modo che chi lo percorre possa ammirare il tuo villaggio in miniatura.|Fatti aiutare da un adulto e cammina a occhi chiusi per circa 50 metri. Tocca, senti, annusa. Cerca di ricordare e scrivi tutte le sensazioni provate senza la vista.",'
          '"assets/percorso3/4.jpeg"'
          ',"Un tesoro nascosto|Personaggi del bosco|Un richiamo speciale|Capanne in miniatura|Il sentiero invisibile"'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3005, "Arrivo Campanile di Fontanella", 45.714750, 9.513528, 3, 0, 0,'
          '"Fontanella dà il nome a una contrada di Sotto il Monte. È una località conosciuta soprattutto per l\'antica abbazia di Sant\'Egidio abate, fondata nel 1080, di cui rimane l’omonima Cappella Vescovile. Nel 1964, colpito dalla morte di Papa Giovanni XXIII, padre David Maria Turoldo, religioso e poeta, approda in questo luogo (vi rimarrà sino alla sua morte) per fondare una comunità religiosa orientata al rinnovamento della preghiera cristiana.",'
          '"",'
          '"Poesia Naturale: pensa a una parola riferita a qualcosa che hai visto oggi e ti ha colpito; scrivila in verticale e usa le lettere che la compongono come iniziali dei versi di una tua poesia.",'
          '"assets/percorso3/6.jpg"'
          ',""'
          ');');
      txn.rawInsert('INSERT INTO '
          '${Tappe.tblTappa} (${Tappe.dbId},${Tappe.dbTitle},${Tappe.dbLat},${Tappe.dbLng},${Tappe.dbPercorsoID},${Tappe.dbStatus},${Tappe.dbLastTappa}, ${Tappe.dbDescription}, ${Tappe.dbIndicazioni},  ${Tappe.dbEsplorazione}, ${Tappe.dbImage}, ${Tappe.dbTitleEsplorazione})'
          ' VALUES(3006, "PERCORSO COMPLETATO!", 45.714750, 9.513528, 3, 0, 1,'
          '"",'
          '"",'
          '"Quando torni a casa, ricordati che puoi sperimentare queste esplorazioni in altri luoghi, persino in casa o in città",'
          '"assets/percorso3.jpeg"'
          ',""'
          ');');
    });
  }
}
