import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_validation/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{

  User? user;
  final storage=FlutterSecureStorage();
  String? authError;//handling error
  bool isAuthenticated=false;
  String token='';
  Future <void> getCurrentUser() async{
    final url="http://167.71.119.67:8000/users/users/me/";
    
    var mytoken=await storage.read(key: 'token');
    final response=await http.get(
      Uri.parse(url),
      headers:{
        'accept': 'application/json',
        'Authorization': 'Bearer ${mytoken}'
      }
    );
    if(response.statusCode==200){
      final data=User.fromJson(jsonDecode(response.body));
      user=data;
      isAuthenticated=true;

    }else{
      await logout();
    }
    notifyListeners();
  }
  Future<void>login(String email,String password)async{
    final url="http://167.71.119.67:8000/users/token";
    final response=await http.post(
      Uri.parse( url),
      headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json'
      },
      body:{'username':email,'password':password}
    );
    if(response.statusCode==200){
      final data=Token.fromJson(jsonDecode(response.body));
      await storage.write(key: 'token', value: data.access_token);
      token=data.access_token;
      isAuthenticated=true;
      
      await getCurrentUser();
    }else {
      
      authError='invalid username or password';
    }
    notifyListeners();
  }


  Future<void>logout() async {
    await storage.delete(key: 'token');
    user=null;
    isAuthenticated=false;
    token='';
    authError=null;
    notifyListeners();
  }

  Future<void>register(String email,String password) async {
    final url="http://167.71.119.67:8000/users/new";
    final response=await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json' 
      },
      body: jsonEncode({'email':email,'password':password})
    );
    if(response.statusCode==200){
      final data=jsonDecode(response.body) as Map<String,dynamic>;
      print(data);
      await login(email, password);
    }else{
      throw Exception('Failed to register');
    }

    notifyListeners();
  }
  
  
}