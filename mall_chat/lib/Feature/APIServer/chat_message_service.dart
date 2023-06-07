import 'dart:convert';
// ignore: implementation_imports
import 'package:http/src/response.dart';
import 'package:mall_chat/Feature/APIServer/Base/base_service.dart';
import 'package:mall_chat/Feature/APIServer/api.dart';
import 'package:mall_chat/Feature/APIServer/user_service.dart';
import 'package:mall_chat/Feature/ChatDetail/Model/chat_model.dart';

class ChatMessageService extends BaseService {
  String? messageCursor;

  Uri get apiURL {
    if (messageCursor == null) {
      return APIURL.historyLatest20;
    }
    Uri baseUri = APIURL.historyByCursor;

    Map<String, dynamic> queryParams = Map.from(baseUri.queryParameters);
    queryParams['cursor'] = messageCursor;

    Uri newUri = baseUri.replace(queryParameters: queryParams);
    return newUri;
  }

  Future<List<ListElement>> getHistory() async {
    try {
      Future<Response> responseData = super.get(apiURL);
      return responseData.then(
        (value) {
          if (value.statusCode == 200) {
            final responseStruct = json.decode(utf8.decode(value.bodyBytes));
            Chat chat = Chat.fromJson(responseStruct);
            messageCursor = chat.data.cursor;
            print("fetch ${chat.data.list.length} messages");
            return chat.data.list;
          } else {
            print('API request failed with status code: ${value.statusCode}');
            return [];
          }
        },
      );
    } catch (e) {
      print("$runtimeType getHistory error: $e");
      return [];
    }
  }

  void sendPostRequest(String message) async {
    Map<String, dynamic> data = {"content": message, "roomId": 1};

    try {
      final response = super.post(
        APIURL.sendingMessage,
        headers: User.userHeader,
        body: json.encode(data),
      );
      return response.then((value) {
        if (value.statusCode == 200) {
          print("Posting message success: $message");
        } else {
          // 请求失败
          print('Request failed with status: ${value.statusCode}');
        }
      });
    } catch (e) {
      // 异常处理
      print('Posting message error: $e');
    }
  }
}
