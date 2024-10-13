import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Screens/auths/Login.dart';
import 'package:frontend/blocs/auths/bloc/auths_bloc.dart';
import 'package:frontend/repos/authrepo.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
    builder:(context,Orientation,DeviceType){ 
      return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=>AuthsBloc(Authrepo())),
      ],
      child:const MaterialApp(
        home: Login(),
      ),
    );});
  }
}
