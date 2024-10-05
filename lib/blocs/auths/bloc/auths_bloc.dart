import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auths_event.dart';
part 'auths_state.dart';

class AuthsBloc extends Bloc<AuthsEvent, AuthsState> {
  AuthsBloc() : super(AuthsInitial()) {
    on<AuthsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
