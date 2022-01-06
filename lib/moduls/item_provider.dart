import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:technical_test_didinamarudin/configs/enum_state.dart';
import 'package:technical_test_didinamarudin/models/checklist_model.dart';
import 'package:technical_test_didinamarudin/models/item_model.dart';
import 'package:technical_test_didinamarudin/moduls/cheklist_service.dart';
import 'package:technical_test_didinamarudin/moduls/item_service.dart';
import 'package:technical_test_didinamarudin/utils/preference_helper.dart';

class ItemProvider extends ChangeNotifier {
  final ItemlistService _service;
  List<DataItem>? _item;
  String _messageNowPlaying = "";
  ResponseResult _resultState = ResponseResult.loading;
  String get messageNowPlaying => _messageNowPlaying;
  ItemProvider(this._service);
  ResponseResult get resultState => _resultState;
  List<DataItem> get list => _item!;
  Future<dynamic> getItem(String itemId) async {
    try {
      String toke = await PreferenceHelper().getToken() ?? "";
      _resultState = ResponseResult.loading;
      notifyListeners();
      final result = await _service.getItem(toke,itemId);
      if (result == null) {
        _resultState = ResponseResult.noData;
        notifyListeners();
        return _messageNowPlaying = "No Data";
      } else {
        _resultState = ResponseResult.hasData;
        notifyListeners();
        return _item = result;
      }
    } catch (e) {
      _resultState = ResponseResult.error;
      notifyListeners();
      return _messageNowPlaying = "check your conectivity";
    }
  }

  void retry(String itemId) {
    getItem(itemId);
  }
}
