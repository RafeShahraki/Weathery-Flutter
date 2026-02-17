import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  final String url2;
  NetworkHelper(this.url, this.url2);

  Future getdata() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getCity() async {
    http.Response cityresponse = await http.get(Uri.parse(url2));
    var data = jsonDecode(cityresponse.body);
    return data;
  }
}
