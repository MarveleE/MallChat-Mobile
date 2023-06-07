import 'package:http/http.dart' as http;

class BaseService {
  final client = http.Client();

  Future<http.Response> get(Uri url) async {
    print("Fetching data from $url ....");
    return await client.get(url);
  }

  Future<http.Response> post(Uri url,
      {required String body, required Map<String, String> headers}) async {
    print("Posting data to $url ....");
    return await client.post(url, headers: headers, body: body);
  }
}
