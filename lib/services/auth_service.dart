import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/user.dart';

class AuthService{
  Future<bool> register({
    required String fullname,
    required String email,
    required String password,
}) async {
    try{
      var url = Uri.parse(APIs.registerApi);
      http.Response response = await http.post(url, body: {
        "firstname": fullname,
        "lastname": "",
        "email": email,
        "password": password,
      });

      log("Here is print: ${response.statusCode}");
      if (response.statusCode == 200){
        var data = jsonDecode(response.body);
        log("Here is print: ${data["code"] == 200}");
        return data["code"] == 200;
      }else{
        return false;
      }
    }catch(e){
      log("Error while registering");
      return false;
    }
  }
  
  
  
  Future<bool> login(String email, String password) async {
    try{
      var url = Uri.parse(APIs.loginApi);
      var response = await http.post(url, body: {
        "username": email,
        "password": password
      });

      ProjectData.user = User.fromMap(jsonDecode(response.body));
      return true;
    }catch(e){
      log("Error while loggin in ${e}");
      return false;
    }
  }
}