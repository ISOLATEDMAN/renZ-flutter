import 'dart:convert';
import 'package:http/http.dart' as http;

class Authrepo {
  final urlLogin = Uri.parse('https://renz-backend.onrender.com/login');//for login
  final urlReg = Uri.parse('https://renz-backend.onrender.com/reg');//for regestrations..
  // final url = Uri.parse('https://localhost:3000/login');//
   // final url = Uri.parse('https://localhost:3000/signup');//
    Future<Map<String, dynamic>> realLogin(String email, String password) async {
    final response = await http.post(
      urlLogin,
      headers: {
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print("status code is good------");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("${response.statusCode}");
      print(response.body);
      return {
        'error': true,
        'message': 'Failed to login : ${response.body}', 
      };
    }
  }

  Future<Map<String,dynamic>> regestration(String email,String pass,String username)async{
    final response = await http.post(
        urlReg,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': pass,
          'username': username,
        }),
      );

      if (response.statusCode == 200) {
        print("Signup successful");
        print(response.body);
        return jsonDecode(response.body);
      } else {
        print("Error: ${response.statusCode}");
        print(response.body);
         return {
        'error': true,
        'message': 'Failed to sign up: ${response.body}', 
      };
  }}
  
}