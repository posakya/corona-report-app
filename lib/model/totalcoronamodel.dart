// To parse this JSON data, do
//
//     final coronaTotalCaseModelClass = coronaTotalCaseModelClassFromJson(jsonString);

import 'dart:convert';

CoronaTotalCaseModelClass coronaTotalCaseModelClassFromJson(String str) => CoronaTotalCaseModelClass.fromJson(json.decode(str));

String coronaTotalCaseModelClassToJson(CoronaTotalCaseModelClass data) => json.encode(data.toJson());

class CoronaTotalCaseModelClass {
  int cases;
  int deaths;
  int recovered;
  int updated;
  int active;

  CoronaTotalCaseModelClass({
    this.cases,
    this.deaths,
    this.recovered,
    this.updated,
    this.active,
  });

  factory CoronaTotalCaseModelClass.fromJson(Map<String, dynamic> json) => CoronaTotalCaseModelClass(
    cases: json["cases"] == null ? null : json["cases"],
    deaths: json["deaths"] == null ? null : json["deaths"],
    recovered: json["recovered"] == null ? null : json["recovered"],
    updated: json["updated"] == null ? null : json["updated"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "cases": cases == null ? null : cases,
    "deaths": deaths == null ? null : deaths,
    "recovered": recovered == null ? null : recovered,
    "updated": updated == null ? null : updated,
    "active": active == null ? null : active,
  };
}
