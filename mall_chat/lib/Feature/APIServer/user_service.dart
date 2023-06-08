import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../main.dart';
import 'Model/member_model.dart';

class User extends ChangeNotifier {
  MemberData? _memberData;

  MemberData? get memberData {
    if (_memberData == null) {
      MemberData? data = loadData();
      _memberData = data;
    }
    return _memberData;
  }

  set memberData(MemberData? value) {
    _memberData = value;

    saveData(value);

    notifyListeners();
  }

  static String prefrencesKey = "user-data";

  saveData(MemberData? myObject) {
    String jsonString = json.encode(myObject?.toJson());
    print("Save $jsonString to local");
    prefs.setString(prefrencesKey, jsonString);
  }

  MemberData? loadData() {
    String? jsonString = prefs.getString(prefrencesKey);
    print("get $jsonString from local");
    if (jsonString != null) {
      return MemberData.fromJson(json.decode(jsonString));
    } else {
      return null;
    }
  }
}
