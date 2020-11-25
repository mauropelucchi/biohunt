import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Percorso {
  static final tblPercorso = "percorsi";
  static final dbId = "id";
  static final dbName = "name";
  static final dbColorCode = "colorCode";
  static final dbColorName = "colorName";

  int id, colorValue;
  String name, colorName;

  Percorso.create(this.name, this.colorValue, this.colorName);

  Percorso.update({@required this.id, name, colorCode = "", colorName = ""}) {
    if (name != "") {
      this.name = name;
    }
    if (colorCode != "") {
      this.colorValue = colorCode;
    }
    if (colorName != "") {
      this.colorName = colorName;
    }
  }

  Percorso.getPercorso1()
      : this.update(
            id: 1,
            name: "La Biofficina del Monte Canto",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Percorso.getPercorso2()
      : this.update(
            id: 2,
            name: "Pietre e vigneti",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Percorso.getPercorso3()
      : this.update(
            id: 3,
            name: "Le due Torri",
            colorName: "Grey",
            colorCode: Colors.grey.value);


  Percorso.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}
