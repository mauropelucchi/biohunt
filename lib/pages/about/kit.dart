import 'package:flutter/material.dart';
import 'package:biohunt/utils/app_constant.dart';
import 'package:biohunt/utils/keys.dart';

class KitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crea il tuo kit",
          key: ValueKey(KitKeys.KIT),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Crea il tuo kit",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading: Icon(Icons.build, color: Colors.black),
                      title: Text(
                        "Prima di partire per l’esplorazione, potrebbe essere utile avere con sé alcuni oggetti utili!"
                      ),
                      subtitle: Text(
                        "\n\nEcco qualche suggerimento:\nuna macchina fotografica\nuna lente di ingrandimento\nun quaderno per appunti e schizzi\nuna matita o una penna\nscotch, spago, forbiciecolla\nuna borsa/sacchetto\nalcuni barattoli o contenito ririciclati",
                        key: ValueKey(AboutUsKeys.PROJECT_NAME),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
