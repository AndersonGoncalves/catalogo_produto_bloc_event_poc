import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalogo_produto_poc/app/core/models/carrinho.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/bloc/carrinho_event.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/bloc/carrinho_state.dart';
import 'package:catalogo_produto_poc/app/services/carrinho/carrinho_service.dart';

class CarrinhoBloc extends Bloc<CarrinhoEvent, CarrinhoState> {
  final CarrinhoService _carrinhoService;

  CarrinhoBloc({required CarrinhoService carrinhoService})
    : _carrinhoService = carrinhoService,
      super(CarrinhoState()) {
    on<CarrinhoAddEvent>(_onCarrinhoAdd);
    on<CarrinhoRemoveEvent>(_onCarrinhoRemove);
    on<CarrinhoRemoveSingleItemEvent>(_onCarrinhoRemoveSingleItem);
    on<CarrinhoClearEvent>(_onCarrinhoClear);
  }

  Map<String, Carrinho> get items => _carrinhoService.items;
  int get quantidadeItem => _carrinhoService.quantidadeItem;
  double get valorTotal => _carrinhoService.valorTotal;

  Future<void> _onCarrinhoAdd(
    CarrinhoAddEvent event,
    Emitter<CarrinhoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      _carrinhoService.add(event.produto);
      emit(
        state.copyWith(
          items: _carrinhoService.items.values.toList(),
          isLoading: false,
          success: true,
          // quantidadeItem: _carrinhoService.quantidadeItem,
          // valorTotal: _carrinhoService.valorTotal,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao adicionar produto: ${e.toString()}',
          isLoading: false,
          success: false,
        ),
      );
    }
  }

  Future<void> _onCarrinhoRemove(
    CarrinhoRemoveEvent event,
    Emitter<CarrinhoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      _carrinhoService.remove(event.produtoId);
      emit(
        state.copyWith(
          items: _carrinhoService.items.values.toList(),
          isLoading: false,
          success: true,
          // quantidadeItem: _carrinhoService.quantidadeItem,
          // valorTotal: _carrinhoService.valorTotal,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao remover produto: ${e.toString()}',
          isLoading: false,
          success: false,
        ),
      );
    }
  }

  Future<void> _onCarrinhoRemoveSingleItem(
    CarrinhoRemoveSingleItemEvent event,
    Emitter<CarrinhoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      _carrinhoService.removeSingleItem(event.produtoId);
      emit(
        state.copyWith(
          items: _carrinhoService.items.values.toList(),
          isLoading: false,
          success: true,
          // quantidadeItem: _carrinhoService.quantidadeItem,
          // valorTotal: _carrinhoService.valorTotal,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao remover item: ${e.toString()}',
          isLoading: false,
          success: false,
        ),
      );
    }
  }

  Future<void> _onCarrinhoClear(
    CarrinhoClearEvent event,
    Emitter<CarrinhoState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));
    try {
      _carrinhoService.clear();
      emit(
        state.copyWith(
          items: _carrinhoService.items.values.toList(),
          isLoading: false,
          success: true,
          // quantidadeItem: _carrinhoService.quantidadeItem,
          // valorTotal: _carrinhoService.valorTotal,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Erro ao limpar carrinho: ${e.toString()}',
          isLoading: false,
          success: false,
        ),
      );
    }
  }
}
