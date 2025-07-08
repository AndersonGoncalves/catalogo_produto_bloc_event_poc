abstract class UsuarioEvent {}

class UsuarioRegisterEvent extends UsuarioEvent {
  final String name;
  final String email;
  final String password;

  UsuarioRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class UsuarioLoginEvent extends UsuarioEvent {
  final String email;
  final String password;

  UsuarioLoginEvent({required this.email, required this.password});
}

class UsuarioGoogleLoginEvent extends UsuarioEvent {}

class UsuarioLoginAnonimoEvent extends UsuarioEvent {}

class UsuarioConverterContaAnonimaEmPermanenteEvent extends UsuarioEvent {
  final String email;
  final String password;

  UsuarioConverterContaAnonimaEmPermanenteEvent({
    required this.email,
    required this.password,
  });
}

class UsuarioLogoutEvent extends UsuarioEvent {}

class UsuarioEsqueceuSenhaEvent extends UsuarioEvent {
  final String email;

  UsuarioEsqueceuSenhaEvent({required this.email});
}
