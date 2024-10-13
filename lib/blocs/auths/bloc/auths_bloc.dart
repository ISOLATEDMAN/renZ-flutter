import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/repos/authrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auths_event.dart';
part 'auths_state.dart';

class AuthsBloc extends Bloc<AuthsEvent, AuthsState> {
  final Authrepo authRepo; 
  AuthsBloc(this.authRepo) : super(AuthsInitial()) {
    on<LoginEventReq>(tryLogin);
    on<RegEventReq>(tryReg);
  }

  Future<void> tryLogin(LoginEventReq event,Emitter<AuthsState> emit)async{
    print("started login process");
    emit(IsLoading());
    final responseJson = await authRepo.realLogin(event.email,event.password);
    final token = responseJson['token'];
    if(responseJson.isNotEmpty && responseJson['error']==true){
      final errorMessage = responseJson['message'] ?? "Registration failed, please try again.";
      emit(RegFailure(errorMessage));
    }
    if(token!=null){
      print("this is the ${token.toString()}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', token);
      emit(LoginSuccesfull(token));
    }
    else{
      emit(LoginFailure("Login failed please try again..."));
    }

  }

  Future<void> tryReg(RegEventReq event,Emitter<AuthsState> emit)async{
    print("started reg process");
    emit(IsLoading());
    final responseJson = await authRepo.regestration(event.email,event.password, event.username);
    if(responseJson.isNotEmpty && responseJson['error']==true){
      final errorMessage = responseJson['message'] ?? "Registration failed, please try again.";
      emit(RegFailure(errorMessage));
    }
    if(responseJson.isNotEmpty){
      emit(RegSucess());
    }
    else{
      emit(RegFailure("regestration failure try again.."));
    }
  }
}
