import 'package:catalogo_produto_poc/app/core/models/produto.dart';

class ProdutoEvent {}

class ProdutoLoadEvent extends ProdutoEvent {
  ProdutoLoadEvent();
}

class ProdutoSaveEvent extends ProdutoEvent {
  final Map<String, dynamic> map;
  ProdutoSaveEvent(this.map);
}

class ProdutoRemoveEvent extends ProdutoEvent {
  final Produto produto;
  ProdutoRemoveEvent(this.produto);
}
