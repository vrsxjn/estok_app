class HistoricDb {
  int id;
  String att;
  String type;
  String date;
  String hour;

  HistoricDb({this.id, this.att, this.type, this.date, this.hour});

  factory HistoricDb.fromJson(Map<String, dynamic> json) {
    return HistoricDb(
        id: json["id"] != null ? (json["id"] as num).toInt() : null,
        att: (json['att'] as String),
        type: (json['type'] as String),
        date: (json['date'] as String),
        hour: (json['hour'] as String));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'att': this.att,
      'type': this.type,
      'date': this.date,
      'hour': this.hour,
    };
  }
}
