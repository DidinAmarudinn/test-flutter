import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/models/checklist_model.dart';

class ChecklistService{
    Future<List<Datum>?> getMyCheck(String token)async{
    try {
      final res = await Api.getCheklist(token);
      if (res is Map && res.containsKey('data')) {
        final data = res['data'];
        if (data is List) {
          return data
              .map<Datum>((u) => Datum.fromJson(u))
              .toList();
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}