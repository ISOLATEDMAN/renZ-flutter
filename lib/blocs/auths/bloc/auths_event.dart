part of 'auths_bloc.dart';

class AuthsEvent extends Equatable {
  const AuthsEvent();

  @override
  List<Object> get props => [];
}

class LoginEventReq extends AuthsEvent{
  final String email;
  final String password;
  LoginEventReq( this.email, this.password);
  @override
  List<Object> get props => [email,password];
}

class RegEventReq extends AuthsEvent{
  final String email;
  final String password;
  final String username;
  RegEventReq(this.email,this.password,this.username);
  @override
  List<Object> get props => [email,password,username];
}


