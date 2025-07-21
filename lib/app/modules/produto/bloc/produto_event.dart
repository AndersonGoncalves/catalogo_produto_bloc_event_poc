import 'package:catalogo_produto_poc/app/core/models/produto.dart';

abstract interface class ProdutoEvent {}

class ProdutoLoadEvent implements ProdutoEvent {
  ProdutoLoadEvent();
}

class ProdutoSaveEvent implements ProdutoEvent {
  final Map<String, dynamic> map;

  ProdutoSaveEvent(this.map);
}

class ProdutoRemoveEvent implements ProdutoEvent {
  final Produto produto;

  ProdutoRemoveEvent(this.produto);
}
