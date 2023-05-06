import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// const API_KEY = String.fromEnvironment('api_key');

class Networker {
  String apiUrl = 'https://rest.coinapi.io/v1/exchangerate/';
  static const API_KEY = String.fromEnvironment('api_key');

  Future<dynamic> getData(String currency, List coins) async {
    var responses = [];
    for (var coin in coins) {
      http.Response response = await http.get(
        Uri.parse('$apiUrl$coin/$currency?apikey=$API_KEY'),
      );
      if (response.statusCode == 200) {
        responses.add(jsonDecode(response.body)['rate']);
      } else {
        print(response.statusCode);
      }
    }
    return responses;
  }
}
