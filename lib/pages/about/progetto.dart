import 'package:flutter/material.dart';
import 'package:biohunt/utils/keys.dart';

class ProgettoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vuoi sapere di più del progetto?",
          key: ValueKey(ProgettoKeys.PROGETTO),
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
                    Text("#CULTURAaiPiediDelCanto è un progetto pensato per aprire lo sguardo su un diverso modo di vivere il proprio territorio, e nello specifico il Monte Canto, luogo di riferimento nella storia e nella cultura non solo dei suoi abitanti ma di tutta la provincia bergamasca. L’idea centrale del progetto è quella di riscoprire il territorio del Monte Canto in una chiave nuova e dinamica: semplici missioni esplorative permetteranno di vivere delle esperienze di vera immersione in natura, acquisendo un senso di maggior consapevolezza rispetto al valore di un ambiente naturale prezioso e ricco di storia. Fare esperienza della natura diventa relazione in ogni momento della vita: è esperienza autentica e non mediata che trasforma l’ordinario in straordinario.\n\nQuesta applicazione, studiata e realizzata ad hoc, è il risultato di questo progetto: uno strumento concreto per riscoprire la vera essenza dell’esplorare, imparare a vedere con occhi nuovi ciò che ci circonda e scoprire, attraverso pillole di cultura, la storia di questo territorio.")
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
