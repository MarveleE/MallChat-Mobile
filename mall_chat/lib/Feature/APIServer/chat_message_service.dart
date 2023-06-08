import 'dart:convert';
// ignore: implementation_imports
import 'package:http/src/response.dart';
import 'package:mall_chat/Feature/APIServer/Base/base_service.dart';
import 'package:mall_chat/Feature/APIServer/Model/send_message_response.dart';
import 'package:mall_chat/Feature/APIServer/api.dart';
import 'package:mall_chat/Feature/ChatDetail/Model/chat_model.dart';

class ChatMessageService extends BaseService {
  String? messageCursor;

  Function(SendMsgResponse)? onSendMsgResponse;

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
        headers: UserInfo().userHeader,
        body: json.encode(data),
      );
      return response.then((value) {
        if (value.statusCode == 200) {
          final responseStruct = json.decode(utf8.decode(value.bodyBytes));
          SendMsgResponse chat = SendMsgResponse.fromJson(responseStruct);
          onSendMsgResponse?.call(chat);
        } else {
          print('Request failed with status: ${value.statusCode}');
        }
      });
    } catch (e) {
      print('Posting message error: $e');
    }
  }
}
