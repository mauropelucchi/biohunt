import 'package:meta/meta.dart';

class Tappe {
  static final tblTappa = "tappe";
  static final dbId = "id";
  static final dbTitle = "title";
  static final dbLng = "lng";
  static final dbLat = "lat";
  static final dbStatus = "stato";
  static final dbPercorsoID = "percorsoId";
  static final dbLastTappa = "lastTappa";
  static final dbDescription = "description";
  static final dbImage = "image";
  static final dbEsplorazione = "esplorazione";
  static final dbIndicazioni = "indicazioni";

  String title, percorsoName, description, image, indicazioni, esplorazione;
  int id, percorsoId, percorsoColor;
  double lat, lng;
  bool lastTappa;
  TappaStatus tappeStatus;

  Tappe.create(
      {@required this.title,
      @required this.percorsoId,
      @required this.lastTappa,
      this.description = "",
      this.image  = "",
      this.indicazioni = "",
      this.esplorazione = "",
      this.lat = 0.0,
      this.lng = 0.0}) {
    this.tappeStatus = TappaStatus.PENDING;
  }

  bool operator ==(o) => o is Tappe && o.id == id;

  Tappe.update(
      {@required this.id,
      @required this.title,
      @required this.percorsoId,
      @required this.lastTappa,
      this.description = "",
      this.image  = "",
      this.indicazioni = "",
      this.esplorazione = "",
      this.lat = 0.0,
      this.lng = 0.0,
      this.tappeStatus = TappaStatus.PENDING});

  Tappe.fromMap(Map<String, dynamic> map)
      : this.update(
          id: map[dbId],
          title: map[dbTitle],
          percorsoId: map[dbPercorsoID],
          lastTappa: map[dbLastTappa] == 0 ? false : true,
          lng: (map[dbLng]).toDouble(),
          lat: (map[dbLat]).toDouble(),
          description: (map[dbDescription]),
          image: (map[dbImage]),
          esplorazione: (map[dbEsplorazione]),
          indicazioni: (map[dbIndicazioni]),
          tappeStatus: TappaStatus.values[map[dbStatus]],
        );

  @override
  int get hashCode => super.hashCode;

}

enum TappaStatus {
  PENDING,
  COMPLETE,
}
