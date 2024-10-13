part of 'auths_bloc.dart';

sealed class AuthsState extends Equatable {
  const AuthsState();
  
  @override
  List<Object> get props => [];
}

final class AuthsInitial extends AuthsState {}


class IsLoading extends AuthsState{}

class LoginSuccesfull extends AuthsState{
  final String jwt;
  LoginSuccesfull(this.jwt);
  @override
  List<Object> get props => [jwt];
}

class LoginFailure extends AuthsState{
  final String msg;
  LoginFailure(this.msg);
  @override
  List<Object> get props => [msg];
}

class RegSucess extends AuthsState{
  RegSucess();
  @override
  List<Object> get props => [];
}


class RegFailure extends AuthsState{
  final String msg;
  RegFailure(this.msg);
  @override
  List<Object> get props => [msg];
}