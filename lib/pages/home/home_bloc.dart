import 'dart:async';

import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/bloc/tappa_bloc.dart';
import 'package:rxdart/rxdart.dart'; 

class HomeBloc implements BlocBase {
  StreamController<String> _titleController = StreamController<String>.broadcast();
  BehaviorSubject<int> _idController = BehaviorSubject<int>();

  Stream<String> get title => _titleController.stream;
  Stream<int> get id => _idController.stream;
  int get currentId => _idController.value;

  StreamController<Filter> _filterController = StreamController<Filter>();

  Stream<Filter> get filter => _filterController.stream;

  @override
  void dispose() {
    _titleController.close();
    _idController.close();
    _filterController.close();
  }

  void updateTitle(String title, int id) {
    _titleController.sink.add(title);
    _idController.sink.add(id);

  }

  void applyFilter(String title, int id, Filter filter) {
    _filterController.sink.add(filter);
    updateTitle(title, id);
  }
}
