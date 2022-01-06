// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
    ItemModel({
        this.statusCode,
        this.message,
        this.errorMessage,
        this.data,
    });

    int? statusCode;
    String? message;
    dynamic errorMessage;
    List<DataItem>? data;

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: List<DataItem>.from(json["data"].map((x) => DataItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataItem {
    DataItem({
        this.id,
        this.name,
        this.itemCompletionStatus,
    });

    int? id;
    String? name;
    bool? itemCompletionStatus;

    factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        id: json["id"],
        name: json["name"],
        itemCompletionStatus: json["itemCompletionStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "itemCompletionStatus": itemCompletionStatus,
    };
}
