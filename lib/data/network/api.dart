import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:technical_test_didinamarudin/models/checklist_model.dart';
import 'package:technical_test_didinamarudin/models/loginmodel.dart';
import 'package:technical_test_didinamarudin/utils/preference_helper.dart';

part 'api_constant.dart';
part 'api_exception.dart';
part 'api_handler.dart';

class Api {
  static final ApiHandler _handler = ApiHandler();
  Future<bool?> loginProccess(String email, String password) async {
    try {
      var dataBody = {"username": email, "password": password};
      final response = await http.post(Uri.parse(baseUrl + login),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        LoginModel loginResponseModel = LoginModel.fromJson(result);
        print(loginResponseModel.data!.token);
        await PreferenceHelper().setToken(loginResponseModel.data!.token!);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> registerProcess(
      String email, String password, String username) async {
    try {
      var dataBody = {
        "email": email,
        "password": password,
        "username": username
      };
      final response = await http.post(Uri.parse(baseUrl + register),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> addCheckList(String checkName) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      var dataBody = {"name": checkName};
      final response = await http.post(Uri.parse(baseUrl + checkList),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future getCheklist(String token) async {
    return await _handler.get(baseUrl + checkList, token);
  }

  static Future getItemByCheckId(String token, String id) async {
    return await _handler.get(baseUrl + checkList + "/" + id + "/item", token);
  }

  Future<bool> deleteChecklist(int? idCheck) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      final response = await http.delete(
        Uri.parse(baseUrl + checkList + "/$idCheck"),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteItem(String idCheck, String idItem) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      final response = await http.delete(
        Uri.parse(baseUrl + checkList + "/$idCheck" + "/item/$idItem"),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool?> addItemCheckList(String itemName, String checkId) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      var dataBody = {"itemName": itemName};
      final response = await http.post(
          Uri.parse(baseUrl + checkList + "/" + checkId + "/item"),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCheck(String idCheck, String idItem) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      var dataBody = {"": ""};
      final response = await http.put(
          Uri.parse(baseUrl + checkList + "/$idCheck" + "/item/$idItem"),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> rename(String idCheck, String idItem,String rename) async {
    try {
      String token = await PreferenceHelper().getToken() ?? "";
      var dataBody = {"itemName": rename};
      final response = await http.put(
          Uri.parse(baseUrl + checkList + "/$idCheck" + "/item/rename/$idItem"),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dataBody));
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
