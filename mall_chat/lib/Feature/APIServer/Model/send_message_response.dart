import 'dart:convert';
import '../../ChatDetail/Model/chat_model.dart';

SendMsgResponse sendMsgResponseFromJson(String str) =>
    SendMsgResponse.fromJson(json.decode(str));

String sendMsgResponseToJson(SendMsgResponse data) =>
    json.encode(data.toJson());

class SendMsgResponse {
  bool success;
  dynamic errCode;
  dynamic errMsg;
  ListElement data;

  SendMsgResponse({
    required this.success,
    this.errCode,
    this.errMsg,
    required this.data,
  });

  factory SendMsgResponse.fromJson(Map<String, dynamic> json) =>
      SendMsgResponse(
        success: json["success"],
        errCode: json["errCode"],
        errMsg: json["errMsg"],
        data: ListElement.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errCode": errCode,
        "errMsg": errMsg,
        "data": data.toJson(),
      };
}
