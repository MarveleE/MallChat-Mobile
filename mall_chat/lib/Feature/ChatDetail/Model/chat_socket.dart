import 'dart:convert';
import 'package:mall_chat/Feature/ChatDetail/Model/chat_model.dart';

SocketMessage socketMessageFromJson(String str) =>
    SocketMessage.fromJson(json.decode(str));

String socketMessageToJson(SocketMessage data) => json.encode(data.toJson());

class SocketMessage {
  int type;
  ListElement data;

  SocketMessage({
    required this.type,
    required this.data,
  });

  factory SocketMessage.fromJson(Map<String, dynamic> json) => SocketMessage(
        type: json["type"],
        data: ListElement.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": data.toJson(),
      };
}
