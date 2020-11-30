import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';
import 'package:biohunt/utils/date_util.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:biohunt/utils/app_constant.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:biohunt/bloc/bloc_provider.dart';

class TappaRow extends StatelessWidget {
  final Tappe tappe;
  final List<String> labelNames = List();
  TappaRow(this.tappe);

  @override
  Widget build(BuildContext context) {
    final TappaBloc tappeBloc = BlocProvider.of(context);
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailTappe(tappa: tappe, tappeBloc: tappeBloc),
          ),
        )
      },
      child: Column(
        children: <Widget>[
          Container(
            key: ValueKey("tappaIdKey_${tappe.id}"),
            margin: const EdgeInsets.symmetric(vertical: PADDING_TINY),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 4.0,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(PADDING_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: ListTile(
                        leading: (tappe.lastTappa)
                            ? Icon(Icons.tour)
                            : Icon(Icons.place),
                        title: (Text(tappe.title,
                            key: ValueKey("tappaTitle_${tappe.id}"),
                            style: TextStyle(
                                fontSize: FONT_SIZE_TITLE,
                                fontWeight: FontWeight.bold)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: PADDING_SMALL, bottom: PADDING_VERY_SMALL),
                    child: Row(
                      children: <Widget>[
                        Text(
                          getFormattedId(tappe.id),
                          style: TextStyle(
                              color: Colors.grey, fontSize: FONT_SIZE_DATE),
                          key: ValueKey("tappaId_${tappe.id}"),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(tappe.percorsoName,
                                      key: ValueKey(
                                          "tappaPercorsoName_${tappe.id}"),
                                      style: TextStyle(
                                          color: Color(tappe.percorsoColor),
                                          fontSize: FONT_SIZE_LABEL)),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    width: 8.0,
                                    height: 8.0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Color(tappe.percorsoColor),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class DetailTappe extends StatelessWidget {
  final int _cIndex = 0;
  final TappaBloc tappeBloc;
  final Tappe tappa;
  DetailTappe({Key key, @required this.tappa, this.tappeBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(tappa.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.map_rounded, color: Color.fromARGB(255, 0, 0, 0)),
              label: 'Mappa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_run,
                  color: Color.fromARGB(255, 0, 0, 0)),
              label: 'Indicazioni')
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMap(tappa: tappa),
              ),
            );
          } else if (index == 1) {
            double latitude = tappa.lat;
            double longitude = tappa.lng;
            String googleUrl =
                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            if (canLaunch(googleUrl) != null) {
              launch(googleUrl);
            } else {
              throw 'Could not open the map.';
            }
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          (!tappa.lastTappa && tappa.tappeStatus == TappaStatus.PENDING)
              ? FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Conferma"),
                          content: const Text("Hai completato questa tappa?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  var tappaID = tappa.id;
                                  tappeBloc.updateStatus(
                                      tappaID, TappaStatus.COMPLETE);
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text("Tappa completata!")),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Annulla"),
                            ),
                          ],
                        );
                      },
                    ).then((value) => {
                          if (value) {Navigator.of(context).pop()}
                        });
                  },
                  child: Icon(
                    Icons.check,
                  ),
                )
              : null,
      body: Container(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children: <Widget>[
                (tappa.description != "") ? Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.description, color: Colors.black),
                        title: Text("Lo sai che?"),
                        subtitle: Text(tappa.description)
                      )
                    ],
                  ),
                ): null,
                (tappa.esplorazione != "") ? Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.search, color: Colors.black),
                        title: Text("Esplorazione"),
                        subtitle: Text(tappa.esplorazione)
                      )
                    ],
                  ),
                ): null,
                (tappa.indicazioni != "") ? Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.map, color: Colors.black),
                        title: Text("Indicazioni"),
                        subtitle: Text(tappa.indicazioni)
                      )
                    ],
                  ),
                ): null
              ]))),

      /*child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(tappa.description),
            Image(
              image: AssetImage(tappa.image),
            ),
          ],
        )),
      ),*/
    );
  }
}

class DetailMap extends StatelessWidget {
  final Tappe tappa;
  DetailMap({Key key, @required this.tappa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(tappa.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FlutterMap(
          mapController: MapController(),
          options: new MapOptions(
            center: new LatLng(tappa.lat, tappa.lng),
            zoom: 16.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  point: new LatLng(tappa.lat, tappa.lng),
                  builder: (ctx) => new Container(
                    child: new Icon(Icons.place, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
