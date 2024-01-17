import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interntask/networking/api_response_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCall {
  static const baseUrl = "https://dummyjson.com/";

  Future<Map<String, dynamic>> postCall(String url, String payload) async {
    final apiEndpoint = baseUrl + url;
    var client = http.Client();

    try {
      final response = await client.post(
        Uri.parse(apiEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      return ApiResponseHandler.responseData(response);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }

  Future<Map<String, dynamic>> putCall(String url, String payload) async {
    final apiEndpoint = baseUrl + url;
    var client = http.Client();

    try {
      final response = await client.put(
        Uri.parse(apiEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      return ApiResponseHandler.responseData(response);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }

  Future<Map<String, dynamic>> login(String url, String payload) async {
    final apiEndpoint = baseUrl + url;
    var client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await client.post(
        Uri.parse(apiEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: payload,
      );

      if (response.statusCode == 200) {
        prefs.setString('token', jsonDecode(response.body)["token"]);
        prefs.setInt('id', jsonDecode(response.body)["id"]);
        prefs.setBool('isLoggedIn', true);
      }

      return ApiResponseHandler.responseData(response);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }

  Future<Map<String, dynamic>> getCall(String url) async {
    final apiEndpoint = baseUrl + url;
    var client = http.Client();

    try {
      final response = await client.get(Uri.parse(apiEndpoint));
      return ApiResponseHandler.responseData(response);
    } catch (error) {
      return ApiResponseHandler.outputError();
    }
  }
}