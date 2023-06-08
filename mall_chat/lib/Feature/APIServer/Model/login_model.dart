import 'dart:convert';

// MARK: - LoginUrl
LoginUrl loginUrlFromJson(String str) => LoginUrl.fromJson(json.decode(str));

String loginUrlToJson(LoginUrl data) => json.encode(data.toJson());

class LoginUrl {
  int type;
  LoginUrlData data;

  LoginUrl({
    required this.type,
    required this.data,
  });

  factory LoginUrl.fromJson(Map<String, dynamic> json) => LoginUrl(
        type: json["type"],
        data: LoginUrlData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}

class LoginUrlData {
  String loginUrl;

  LoginUrlData({
    required this.loginUrl,
  });

  factory LoginUrlData.fromJson(Map<String, dynamic> json) => LoginUrlData(
        loginUrl: json["loginUrl"],
      );

  Map<String, dynamic> toJson() => {
        "loginUrl": loginUrl,
      };
}
