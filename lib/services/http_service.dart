import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_mobxx/core/base_url.dart';
import 'package:todo_mobxx/services/preference_service.dart';

abstract class ApiService {

  Future<Map<String, dynamic>> delete(String url,
      {bool useAuthHeaders = true, body}) async {
    print(body);
    final request = http.Request("DELETE", Uri.parse(_getUrl(url)));
    request.headers.addAll(await _getHeaders(useAuthHeaders: useAuthHeaders));
    if (body != null) {
      request.body = json.encode(body);
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return await _getResponse(response);
  }

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> params, bool useAuthHeaders = true}) async {
    final response = await http.get(_getUrlWithParams(url, params: params),
        headers: await _getHeaders(useAuthHeaders: useAuthHeaders));
    return await _getResponse(response);
  }

  Future<Map<String, dynamic>> post(String url,
      {@required body, bool useAuthHeaders = true}) async {
    print(body);
    final response = await http.post(this._getUrl(url),
        headers: (await this._getHeaders(useAuthHeaders: useAuthHeaders)),
        body: json.encode(body));
    return await _getResponse(response);
  }

  Future<Map<String, dynamic>> put(String url,
      {@required body, bool useAuthHeaders = true}) async {
    final response = await http.put(this._getUrl(url),
        headers: (await this._getHeaders(useAuthHeaders: useAuthHeaders)),
        body: json.encode(body));
    return await _getResponse(response);
  }



  String _getUrl(String url) {
    return BASE_URL + url;
  }

  Future<Map<String, String>> _getHeaders({useAuthHeaders = true}) async {
    final map = Map<String, String>.from({"Content-Type": "application/json"});
    if (useAuthHeaders) {
      map["Authorization"] =
      "Bearer ${await PreferencesService().getAuthToken()}";
    }
    return map;
  }

  String _getUrlWithParams(url, {Map<String, String> params}) {
    var apiUrl = this._getUrl(url);
    if (params != null) {
      var paramsString = "";
      params.forEach((key, value) {
        paramsString += "&$key=$value";
      });
      return apiUrl + "?" + paramsString.substring(1);
    }
    return apiUrl;
  }

  Future<Map<String, dynamic>> _getResponse(http.Response response) async {
    if (response.body.isEmpty) {
      return {'message': 'Success'};
    } else {
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 401) {
        await PreferencesService().removeAuthToken();
        throw ('You are logged out. Please login again.');
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        print('error in response');
        if (body['errors'] != null) {
          print(body['errors'].toString());
          print(body['errors'].runtimeType.toString());
          bool type = body['errors'].runtimeType.toString() == 'List<dynamic>';
          print(type);
          if (body['errors'].runtimeType.toString() == 'List<dynamic>') {
            List<dynamic> errList = body['errors'];
            if (errList.length > 0) {
              Map<String, dynamic> errors = errList[0];
              if (errors.keys.length > 0)
                throw (errors[errors.keys.elementAt(1)].toString());
            }
          } else {
            Map<String, dynamic> errors = body['errors'];
            if (errors.keys.length > 0)
              throw (errors[errors.keys.elementAt(1)][0].toString());
          }
          print(body['errors'].runtimeType);
        } else if (body['message'] != null) {
          throw (body['message']);
        } else {
          throw ('Something went wrong!');
        }
      }
      return body;
    }
  }
}
