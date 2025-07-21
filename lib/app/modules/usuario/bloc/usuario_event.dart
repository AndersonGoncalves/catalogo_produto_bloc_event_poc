abstract interface class UsuarioEvent {}

class UsuarioRegisterEvent implements UsuarioEvent {
  final String name;
  final String email;
  final String password;

  UsuarioRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UsuarioLoginEvent implements UsuarioEvent {
  final String email;
  final String password;

  UsuarioLoginEvent({required this.email, required this.password});
}

class UsuarioGoogleLoginEvent implements UsuarioEvent {}

class UsuarioLoginAnonimoEvent implements UsuarioEvent {}

class UsuarioConverterContaAnonimaEmPermanenteEvent implements UsuarioEvent {
  final String email;
  final String password;

  UsuarioConverterContaAnonimaEmPermanenteEvent({
    required this.email,
    required this.password,
  });
}

class UsuarioLogoutEvent implements UsuarioEvent {}

class UsuarioEsqueceuSenhaEvent implements UsuarioEvent {
  final String email;

  UsuarioEsqueceuSenhaEvent({required this.email});
}
