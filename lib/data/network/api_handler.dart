part of 'api.dart';

abstract class ApiHandler {
  Future get(String url,String token);
  Future post(String url, dynamic body);
  Future put(String url, dynamic body);
  Future delete(String url);
  factory ApiHandler() => _ApiHandlerImpl();
}

class _ApiHandlerImpl implements ApiHandler {
 @override
  Future get(String url, String token) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "authorization": "Bearer " + token,
        },
      );
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future post(String url, body) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future put(String url, body) async {
    try {
      final response = await http.put(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(url));
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _process(http.Response response) {
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        return json.decode(response.body.toString());
      case 401:
        return json.decode(response.body.toString());
      case 403:
      case 404:
        return json.decode(response.body.toString());
      case 500:
      default:
        return FetchDataException(
          'Error occured while connecting to server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
