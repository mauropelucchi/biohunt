var monthsNames = [
  "Gen",
  "Feb",
  "Mar",
  "Apr",
  "Mag",
  "Giu",
  "Lug",
  "Ago",
  "Set",
  "Ott",
  "Nov",
  "Dic"
];

String getFormattedDate(int dueDate) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dueDate);
  return "${monthsNames[date.month - 1]}  ${date.day}";
}

String getFormattedId(int id) {
  return "#  $id";
}