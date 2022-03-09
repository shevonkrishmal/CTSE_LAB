import 'dart:convert';

import 'package:http/http.dart';

class AgifyServices {
  static const String BASE_URL = "https://api.agify.io";

  const AgifyServices();

  Future<int?> getAgeFromName(String name) async {
    Response response =
        await get(Uri.parse(BASE_URL).replace(queryParameters: {'name': name}));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['age'];
    } else {
      throw Exception('Failed to load age');
    }
  }
}
