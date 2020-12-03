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
                        "Durante l’esplorazione potresti avere bisogno di alcuni oggetti utili! Preparali prima di partire."
                      ),
                      subtitle: Text(
                        "\n\nEcco qualche suggerimento:\n\n- una macchina fotografica\n\n- una lente di ingrandimento\n\n- un quaderno per appunti e schizzi\n\n- una matita o una penna\nscotch, spago, forbici e colla\n\n- una borsa/sacchetto\n\n- alcuni barattoli o contenitori riciclati",
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
