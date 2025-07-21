import 'package:catalogo_produto_poc/app/core/models/produto.dart';

abstract interface class CarrinhoEvent {}

class CarrinhoAddEvent implements CarrinhoEvent {
  final Produto produto;

  CarrinhoAddEvent(this.produto);
}

class CarrinhoRemoveEvent implements CarrinhoEvent {
  final String produtoId;

  CarrinhoRemoveEvent(this.produtoId);
}

class CarrinhoRemoveSingleItemEvent implements CarrinhoEvent {
  final String produtoId;

  CarrinhoRemoveSingleItemEvent(this.produtoId);
}

class CarrinhoClearEvent implements CarrinhoEvent {}
