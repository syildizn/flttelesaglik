class DataSheet {
  final int? date;
  final String monthName;
  final String subjectName;
  final String dayName;
  final String time;

  DataSheet(
      this.date, this.monthName, this.subjectName, this.dayName, this.time);
}

List<DataSheet> dateSheet = [
  DataSheet(null, 'Null', 'Null', 'Null', 'Null'),

];