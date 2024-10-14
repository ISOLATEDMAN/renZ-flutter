import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Screens/auths/Login.dart';
import 'package:frontend/blocs/auths/bloc/auths_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
      TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    bool isLoading = false;
    final formKey = GlobalKey<FormState>();

    Future<void> handleSignup() async {
      if (formKey.currentState?.validate() ?? false) {
        BlocProvider.of<AuthsBloc>(context).add(RegEventReq(
            emailController.text,
            passwordController.text,
            nameController.text));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please correct the errors in the form')),
        );
      }
    }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: BlocListener<AuthsBloc, AuthsState>(
            listener: (context, state) {
              if (state is RegSucess) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const Login()));
              } else if (state is RegFailure) {
                Navigator.of(context).pop(); // Dismiss the loading dialog
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.msg)));
              }},
              child:BlocBuilder<AuthsBloc, AuthsState>(
                builder: (context, state) {
                  if(state is IsLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
                              }
                  return Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 350,
                        height: 75,
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email";
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 75,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
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
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 350,
                        height: 75,
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: 350,
                              height: 60,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Color.fromARGB(255, 96, 85, 216)),
                                  elevation: WidgetStatePropertyAll(30),
                                ),
                                onPressed: handleSignup,
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 80),
                          const Text("Already have an account?"),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
           
          ),
        ),
      ),
    );
  }
}
