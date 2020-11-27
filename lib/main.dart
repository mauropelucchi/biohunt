import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/home/home.dart';
import 'package:biohunt/pages/home/home_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/services.dart' ;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/firstpage': (context) => FirstPage(),
          '/help': (context) => OnBoardingPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.green[400], primaryColor: Colors.green[400]),
        home: OnBoardingPage());
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => FirstPage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 15.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "#CULTURAaiPiediDelCanto",
          body:
              "“Tu sei un esploratore. La tua missione è documentare e osservare il mondo intorno a te come se non l’avessi mai visto prima” (Keri Smith). Un progetto realizzato dall’Associazione Lumaca Ribelle, con il contributo della Fondazione della Comunità Bergamasca",
          image: _buildImage('progetto.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Esplora il Monte Canto",
          body:
              "Cliccando sull'immagine di uno dei tre percorsi proposti potrai accedere al percorso e svolgere le attività proposte. Prima di partire consulta la sezione Crea il tuo Kit per non dimenticare alcuni oggetti fondamentali per le tue esplorazioni.",
          image: _buildImage('help/img1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Le Tappe",
          body:
              "Ogni percorso è composto da 6 tappe. Clicca sulla Tappa per ottenere il tragitto, scoprire le attività proposte e leggere qualche curiosità sul territorio",
          image: _buildImage('help/img2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Completa tutte le tappe",
          body:
              "Dopo aver completato la tappa, premi il tasto di conferma. Il tuo obiettivo è completare tutti i punti del percorso",
          image: _buildImage('help/img3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Vuoi rivivere le attività?",
          body:
              "Clicca sul pulsante Tappe Completate per rivedere le attività che hai già scoperto, rivivere ogni singola tappa oppure ricominciare da capo rifacendo il percorso!",
          image: _buildImage('help/img4.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Inizia l'esplorazione!",
          body:
              "Inizia a esplorare il Monte Canto: scegli un percorso e parti per le attività proposte",
          image: _buildImage('progetto.jpeg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Salta'),
      next: const Icon(Icons.arrow_forward),
      done:
          const Text('Pronti!', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
          title: Text("#CULTURAaiPiediDelCanto"),
          automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(startId: 1),
                  ),
                )
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(children: <Widget>[
                      Image.asset('assets/percorso1.jpeg',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.23),
                      Text("\nLa Biofficina del Monte Canto (Carvico)",
                          style: TextStyle(color: Colors.white)),
                    ])),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(startId: 2),
                  ),
                )
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(children: <Widget>[
                      Image.asset('assets/percorso2.jpeg',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.23),
                      Text("\nPietre e vigneti (tra Carvico e Villa d’Adda)",
                          style: TextStyle(color: Colors.white)),
                    ])),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(startId: 3),
                  ),
                )
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(children: <Widget>[
                      Image.asset('assets/percorso3.jpeg',
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.23),
                      Text("\nLe due Torri (Sotto il Monte Giovanni XXIII)",
                          style: TextStyle(color: Colors.white)),
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final startId;
  SecondPage({Key key, @required this.startId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return BlocProvider(
      bloc: HomeBloc(),
      child: HomePage(startId: this.startId),
    );
  }
}
