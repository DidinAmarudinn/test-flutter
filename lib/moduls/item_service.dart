import 'package:technical_test_didinamarudin/data/network/api.dart';
import 'package:technical_test_didinamarudin/models/item_model.dart';

class ItemlistService{
    Future<List<DataItem>?> getItem(String token,String idCheck)async{
    try {
      final res = await Api.getItemByCheckId(token,idCheck);
      if (res is Map && res.containsKey('data')) {
        final data = res['data'];
        if (data is List) {
          return data
              .map<DataItem>((u) => DataItem.fromJson(u))
              .toList();
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}