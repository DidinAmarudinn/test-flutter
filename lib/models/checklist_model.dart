// To parse this JSON data, do
//
//     final checklistModel = checklistModelFromJson(jsonString);

import 'dart:convert';

ChecklistModel checklistModelFromJson(String str) => ChecklistModel.fromJson(json.decode(str));

String checklistModelToJson(ChecklistModel data) => json.encode(data.toJson());

class ChecklistModel {
    ChecklistModel({
        this.statusCode,
        this.message,
        this.errorMessage,
        this.data,
    });

    int? statusCode;
    String? message;
    dynamic errorMessage;
    List<Datum>? data;

    factory ChecklistModel.fromJson(Map<String, dynamic> json) => ChecklistModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.items,
        this.checklistCompletionStatus,
    });

    int? id;
    String? name;
    dynamic items;
    bool? checklistCompletionStatus;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        items: json["items"],
        checklistCompletionStatus: json["checklistCompletionStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": items,
        "checklistCompletionStatus": checklistCompletionStatus,
    };
}
