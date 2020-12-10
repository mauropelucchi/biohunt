import 'package:flutter/material.dart';
import 'package:biohunt/utils/app_constant.dart';
import 'package:biohunt/utils/app_util.dart';
import 'package:biohunt/utils/keys.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informazioni",
          key: ValueKey(AboutUsKeys.TITLE_ABOUT),
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
                    ListTile(
                        leading: Icon(Icons.bug_report, color: Colors.black),
                        title: Text(
                          "Mandaci un feedback",
                          key: ValueKey(AboutUsKeys.TITLE_REPORT),
                        ),
                        subtitle: Text(
                          "Hai un problema ? Scrivici",
                          key: ValueKey(AboutUsKeys.SUBTITLE_REPORT),
                        ),
                        onTap: () => launchURL(EMAIL_URL)),
                    ListTile(
                      leading: Icon(Icons.update, color: Colors.black),
                      title: Text("Version"),
                      subtitle: Text(
                        "1.4.0",
                        key: ValueKey(AboutUsKeys.VERSION_NUMBER),
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Informazioni",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    ListTile(
                      leading: Icon(Icons.info, color: Colors.black),
                      title: Text(
                        "Un progetto dell’Associazione Lumaca Ribelle",
                        key: ValueKey(AboutUsKeys.AUTHOR_NAME),
                      )
                    ),
                    ListTile(
                      leading: Image.asset("assets/labirinto.jpeg"),
                      title: Text(
                        "Realizzato in collaborazione con Cooperativa Labirinto",
                        key: ValueKey(AboutUsKeys.AUTHOR_NAME),
                      )
                    ),
                    ListTile(
                      title: Text(
                        "Con il contributo della Fondazione della Comunità Bergamasca",
                        key: ValueKey(AboutUsKeys.AUTHOR_NAME),
                      )
                    ),
                    Image.asset("assets/fondazione.jpeg"),
                    ListTile(
                        leading: Icon(Icons.email, color: Colors.black),
                        title: Text("Scrivici una mail"),
                        subtitle: Text(
                          "associazionelumacaribelle@gmail.com",
                          key: ValueKey(AboutUsKeys.AUTHOR_EMAIL),
                        ),
                        onTap: () => launchURL(EMAIL_URL)),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                      child: Text("Hai una domanda ?",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_MEDIUM)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Image.asset("assets/facebook_logo.png"),
                            onPressed: () => launchURL(FACEBOOK_URL),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        subtitle: Text("Copyright © Associazione Lumaca Ribelle 2020"),
                      ),
                    ),
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
