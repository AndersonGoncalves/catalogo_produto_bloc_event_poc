import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/exceptions/auth_exception.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/bloc/usuario_state.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/bloc/usuario_event.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final UsuarioServiceImpl _usuarioService;

  UsuarioBloc({required UsuarioServiceImpl usuarioService})
    : _usuarioService = usuarioService,
      super(UsuarioState()) {
    on<UsuarioRegisterEvent>(_onUsuarioRegister);
    on<UsuarioLoginEvent>(_onUsuarioLogin);
    on<UsuarioGoogleLoginEvent>(_onUsuarioGoogleLogin);
    on<UsuarioLoginAnonimoEvent>(_onUsuarioLoginAnonimo);
    on<UsuarioConverterContaAnonimaEmPermanenteEvent>(
      _onUsuarioConverterContaAnonimaEmPermanente,
    );
    on<UsuarioLogoutEvent>(_onUsuarioLogout);
    on<UsuarioEsqueceuSenhaEvent>(_onUsuarioEsqueceuSenha);
  }

  Future<void> _onUsuarioRegister(
    UsuarioRegisterEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      final user = await _usuarioService.register(
        event.name,
        event.email,
        event.password,
      );
      if (user != null) {
        emit(state.copyWith(isLoading: false, success: true));
      } else {
        emit(
          state.copyWith(isLoading: false, error: 'Erro ao registrar usuário'),
        );
      }
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Erro ao registrar usuário: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUsuarioLogin(
    UsuarioLoginEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      final user = await _usuarioService.login(event.email, event.password);
      if (user != null) {
        emit(state.copyWith(isLoading: false, success: true));
      } else {
        emit(
          state.copyWith(isLoading: false, error: 'Usuário ou senha inválida'),
        );
      }
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    }
  }

  Future<void> _onUsuarioGoogleLogin(
    UsuarioGoogleLoginEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      final user = await _usuarioService.googleLogin();
      if (user != null) {
        emit(state.copyWith(isLoading: false, success: true));
      } else {
        _usuarioService.logout();
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Erro ao realizar login com Google',
          ),
        );
      }
    } on AuthException catch (e) {
      _usuarioService.logout();
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Erro ao realizar login com Google: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUsuarioLoginAnonimo(
    UsuarioLoginAnonimoEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      await _usuarioService.loginAnonimo();
      emit(state.copyWith(isLoading: false, success: true));
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    }
  }

  Future<void> _onUsuarioConverterContaAnonimaEmPermanente(
    UsuarioConverterContaAnonimaEmPermanenteEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      final user = await _usuarioService.converterContaAnonimaEmPermanente(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(state.copyWith(isLoading: false, success: true));
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Não foi possível converter o usuário anônimo',
          ),
        );
      }
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Não foi possível converter o usuário anônimo: ${e.message}',
        ),
      );
    }
  }

  Future<void> _onUsuarioLogout(
    UsuarioLogoutEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      await _usuarioService.logout();
      emit(state.copyWith(isLoading: false, success: true));
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    }
  }

  Future<void> _onUsuarioEsqueceuSenha(
    UsuarioEsqueceuSenhaEvent event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      await _usuarioService.esqueceuSenha(event.email);
      emit(state.copyWith(isLoading: false, success: true));
    } on AuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Erro ao resetar senha: ${e.toString()}',
        ),
      );
    }
  }
}
