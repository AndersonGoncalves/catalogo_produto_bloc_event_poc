import 'package:catalogo_produto_poc/app/core/models/produto.dart';

abstract class CarrinhoEvent {}

class CarrinhoAddEvent extends CarrinhoEvent {
  final Produto produto;

  CarrinhoAddEvent(this.produto);
}

class CarrinhoRemoveEvent extends CarrinhoEvent {
  final String produtoId;

  CarrinhoRemoveEvent(this.produtoId);
}

class CarrinhoRemoveSingleItemEvent extends CarrinhoEvent {
  final String produtoId;

  CarrinhoRemoveSingleItemEvent(this.produtoId);
}

class CarrinhoClearEvent extends CarrinhoEvent {}
