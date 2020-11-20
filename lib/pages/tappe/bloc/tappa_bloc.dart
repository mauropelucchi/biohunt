import 'dart:async';
import 'dart:collection';

import 'package:biohunt/bloc/bloc_provider.dart';
import 'package:biohunt/pages/tappe/tappa_db.dart';
import 'package:biohunt/pages/tappe/models/tappe.dart';

class TappaBloc implements BlocBase {
  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  StreamController<List<Tappe>> _tappaController =
      StreamController<List<Tappe>>.broadcast();

  Stream<List<Tappe>> get tappe => _tappaController.stream;

  ///
  StreamController<int> _cmdController = StreamController<int>.broadcast();

  TappaDB _tappaDb;
  List<Tappe> _tappeList;
  Filter _lastFilterStatus;

  TappaBloc(this._tappaDb) {
    filterByPercorso(1);
    _cmdController.stream.listen((_) {
      _updateTappaStream(_tappeList);
    });
  }

  void _updateTappaStream(List<Tappe> tappe) {
    _tappeList = tappe;
    _tappaController.sink.add(UnmodifiableListView<Tappe>(_tappeList));
  }

  void dispose() {
    _tappaController.close();
    _cmdController.close();
  }

  void filterByPercorso(int percorsoId) {
    _tappaDb
        .getTappeByPercorso(percorsoId, status: TappaStatus.PENDING)
        .then((tappe) {
      if (tappe == null) return;
      _lastFilterStatus = Filter.byPercorso(percorsoId);
      _updateTappaStream(tappe);
    });
  }

  void filterByStatus(TappaStatus status) {
    _tappaDb.getTappe(tappaStatus: status).then((tappe) {
      if (tappe == null) return;
      _lastFilterStatus = Filter.byStatus(status);
      _updateTappaStream(tappe);
    });
  }

  void updateStatus(int tappaID, TappaStatus status) {
    _tappaDb.updateTappaStatus(tappaID, status).then((value) {
      refresh();
    });
  }

  void refresh() {
    if (_lastFilterStatus != null) {
      switch (_lastFilterStatus.filterStatus) {

        case FILTER_STATUS.BY_PERCORSO:
          filterByPercorso(_lastFilterStatus.percorsoId);
          break;

        case FILTER_STATUS.BY_STATUS:
          filterByStatus(_lastFilterStatus.status);
          break;
      }
    }
  }

  void updateFilters(Filter filter) {
    _lastFilterStatus = filter;
    refresh();
  }
}

enum FILTER_STATUS {BY_PERCORSO, BY_STATUS }

class Filter {
  String labelName;
  int percorsoId;
  FILTER_STATUS filterStatus;
  TappaStatus status;

  Filter.byPercorso(this.percorsoId) {
    filterStatus = FILTER_STATUS.BY_PERCORSO;
  }

  Filter.byStatus(this.status) {
    filterStatus = FILTER_STATUS.BY_STATUS;
  }

  bool operator ==(o) =>
      o is Filter &&
      o.labelName == labelName &&
      o.percorsoId == percorsoId &&
      o.filterStatus == filterStatus &&
      o.status == status;

  @override
  int get hashCode => super.hashCode;

}
