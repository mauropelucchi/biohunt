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

  Percorso.getFontanella()
      : this.update(
            id: 1,
            name: "Fontanella",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Percorso.getSanGiovanni()
      : this.update(
            id: 2,
            name: "San Giovanni",
            colorName: "Grey",
            colorCode: Colors.grey.value);

  Percorso.fromMap(Map<String, dynamic> map)
      : this.update(
            id: map[dbId],
            name: map[dbName],
            colorCode: map[dbColorCode],
            colorName: map[dbColorName]);
}
