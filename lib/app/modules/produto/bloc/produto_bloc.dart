import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service.dart';
import 'package:catalogo_produto_poc/app/modules/produto/bloc/produto_event.dart';
import 'package:catalogo_produto_poc/app/modules/produto/bloc/produto_state.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  final ProdutoService _produtoService;

  ProdutoBloc({required ProdutoService produtoService})
    : _produtoService = produtoService,
      super(ProdutoState()) {
    on<ProdutoLoadEvent>(_onLoadProdutos);
    on<ProdutoSaveEvent>(_onSaveProduto);
    on<ProdutoRemoveEvent>(_onRemoveProduto);
  }

  Future<void> _onLoadProdutos(
    ProdutoLoadEvent event,
    Emitter<ProdutoState> emit,
  ) async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao carregar produtos: ${e.toString()}',
          success: false,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onSaveProduto(
    ProdutoSaveEvent event,
    Emitter<ProdutoState> emit,
  ) async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.save(event.map);
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao cadastrar produto: ${e.toString()}',
          success: false,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onRemoveProduto(
    ProdutoRemoveEvent event,
    Emitter<ProdutoState> emit,
  ) async {
    emit(state.copyWith(error: null, success: false, isLoading: true));
    try {
      await _produtoService.delete(event.produto);
      await _produtoService.get();
      emit(
        state.copyWith(
          produtos: _produtoService.produtos,
          success: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao remover produto: ${e.toString()}',
          success: false,
          isLoading: false,
        ),
      );
    }
  }
}
