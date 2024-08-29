import 'package:bloc/bloc.dart';
import 'package:recipe_app/bloc/auth/auth_events.dart';
import 'package:recipe_app/bloc/auth/auth_state.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<AppStartedEvent>(_onAppStarted);
    add(AppStartedEvent());
  }
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final data = await AuthService().login(event.email, event.password);
      emit(AuthAuthenticated(data['data']['token']));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAppStarted(
      AppStartedEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = await AuthService().isLoggedIn();
    if (isLoggedIn) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String userToken = sharedPreferences.getString('userToken')!;

      emit(AuthAuthenticated(userToken));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final data = await AuthService().register(
        event.name,
        event.email,
        event.password,
        event.comfirmPassword,
        event.phone,
      );
      emit(AuthAuthenticated(data['data']['token']));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      emit(AuthLogedout());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
