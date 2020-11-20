import 'package:flutter/material.dart';
import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/home/home.dart';
import 'package:biohunt/pages/home/home_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.green[400], primaryColor: Colors.green[400]),
        home: BlocProvider(
          bloc: HomeBloc(),
          child: HomePage(),
        ));
  }
}
