part of 'auths_bloc.dart';

sealed class AuthsState extends Equatable {
  const AuthsState();
  
  @override
  List<Object> get props => [];
}

final class AuthsInitial extends AuthsState {}
