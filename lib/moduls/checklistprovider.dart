import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:technical_test_didinamarudin/configs/enum_state.dart';
import 'package:technical_test_didinamarudin/models/checklist_model.dart';
import 'package:technical_test_didinamarudin/moduls/cheklist_service.dart';
import 'package:technical_test_didinamarudin/utils/preference_helper.dart';

class CheckProvider extends ChangeNotifier {
  final ChecklistService _service;
  List<Datum>? _nowPlaying;
  String _messageNowPlaying = "";
  ResponseResult _resultState = ResponseResult.loading;
  String get messageNowPlaying => _messageNowPlaying;
  CheckProvider(this._service);
  ResponseResult get resultState => _resultState;
  List<Datum> get list => _nowPlaying!;
  Future<dynamic> getChekList() async {
    try {
      String toke = await PreferenceHelper().getToken() ?? "";
      _resultState = ResponseResult.loading;
      notifyListeners();
      final result = await _service.getMyCheck(toke);
      if (result == null) {
        _resultState = ResponseResult.noData;
        notifyListeners();
        return _messageNowPlaying = "No Data";
      } else {
        _resultState = ResponseResult.hasData;
        notifyListeners();
        return _nowPlaying = result;
      }
    } catch (e) {
      _resultState = ResponseResult.error;
      notifyListeners();
      return _messageNowPlaying = "check your conectivity";
    }
  }

  void retry() {
    getChekList();
  }
}
