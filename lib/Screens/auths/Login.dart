import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Screens/auths/signup.dart';
import 'package:frontend/Screens/baseBottomNavBar.dart';
import 'package:frontend/blocs/auths/bloc/auths_bloc.dart';
import 'package:frontend/constants/appConst.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final formKeyy = GlobalKey<FormState>();

  Future<void> handleRealLogin() async {
    if (formKeyy.currentState?.validate() ?? false) {
      BlocProvider.of<AuthsBloc>(context)
          .add(LoginEventReq(email.text, pass.text));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please correct the errors in the form')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.backgroundWhite,
      appBar: AppBar(),
      body: Form(
        key: formKeyy,
        child: BlocListener<AuthsBloc, AuthsState>(
          listener: (context, state) {
            if (state is LoginSuccesfull) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Basebottomnavbar()));
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            }
          },
          child: BlocBuilder<AuthsBloc, AuthsState>(
            builder: (context, state) {
              if(state is IsLoading){
                return const Center(
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
                        fillColor: AppConst.backgroundWhite,
                        filled: true,
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: AppConst.greyTextfield),
                        labelStyle: TextStyle(
                            color: AppConst.greyTextfield),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 5,
                              color: AppConst.backgroundWhite),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 5,
                              color: AppConst.backgroundWhite),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
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
                            fillColor: AppConst.backgroundWhite,
                            filled: true,
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: AppConst.greyTextfield),
                            labelStyle: TextStyle(
                                color: AppConst.greyTextfield),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: AppConst.backgroundWhite),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 5, color: AppConst.backgroundWhite),
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            AppConst.themeColorPurple),
                        elevation: WidgetStatePropertyAll(30),
                      ),
                      onPressed: handleRealLogin,
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          color: AppConst.backgroundWhite,
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
                            color: AppConst.blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
