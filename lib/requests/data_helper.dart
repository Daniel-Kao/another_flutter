import 'dart:collection';

class DataHelper {
  static SplayTreeMap getBaseMap() {
    var map = new SplayTreeMap<String, dynamic>();
    map["platform"] = "1";
    map["system"] = "android";
    map["channel"] = "official";
    map["time"] = new DateTime.now().millisecondsSinceEpoch.toString();
    return map;
  }
}
