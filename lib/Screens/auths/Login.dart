import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Screens/Home.dart';
import 'package:frontend/Screens/auths/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final formKeyy = GlobalKey<FormState>();
  bool isloading = false;

  Future<Map<String, dynamic>> realLogin(String email, String password) async {
    final url = Uri.parse('https://renz-backend.onrender.com/login');
    final response = await http.post(
      url,
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
      throw Exception('Failed to login');
    }
  }

  Future<void> handleRealLogin() async {
    if (formKeyy.currentState?.validate() ?? false) {
      setState(() {
        isloading = true;
      });
      try {
        final response = await realLogin(email.text, pass.text);
        final token = response['token'];
        if (token != null) {
          // Store the token securely using SharedPreferences
          print("this is the ${token.toString()}");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('jwt', token);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login failed: Token is missing')));
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $error')));
            print("the error is  $error");
      } finally {
        setState(() {
          isloading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please correct the errors in the form')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(),
      body: Form(
        key: formKeyy,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LogIn",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              height: 75,
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: "Enter Email",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an email";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 75,
              child: TextFormField(
                controller: pass,
                decoration: const InputDecoration(
                  labelText: "Password",
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: "Enter Password",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                  labelStyle: TextStyle(color: Color.fromARGB(255, 155, 155, 155)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            isloading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 96, 85, 216),
                        ),
                        elevation: WidgetStatePropertyAll(30),
                      ),
                      onPressed: handleRealLogin,
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 80),
                const Text("Don't have an account?"),
                const SizedBox(width: 10),
                InkWell(
                  child: Text(
                    "SignUp",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => const Signup()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
