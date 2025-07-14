import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catalogo_produto_poc/app/app_widget.dart';
import 'package:catalogo_produto_poc/app/modules/usuario/bloc/usuario_bloc.dart';
import 'package:catalogo_produto_poc/app/services/usuario/usuario_service_impl.dart';
import 'package:catalogo_produto_poc/app/services/produto/produto_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/produto/bloc/produto_bloc.dart';
import 'package:catalogo_produto_poc/app/repositories/produto/produto_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/usuario/usuario_repository_impl.dart';
import 'package:catalogo_produto_poc/app/repositories/carrinho/carrinho_repository_impl.dart';
import 'package:catalogo_produto_poc/app/services/carrinho/carrinho_service_impl.dart';
import 'package:catalogo_produto_poc/app/modules/carrinho/bloc/carrinho_bloc.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Usuario
        BlocProvider<UsuarioBloc>(
          create: (context) {
            final usuarioRepository = UsuarioRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            );
            final usuarioService = UsuarioServiceImpl(
              usuarioRepository: usuarioRepository,
            );
            return UsuarioBloc(usuarioService: usuarioService);
          },
        ),

        //Produto
        BlocProvider<ProdutoBloc>(
          create: (context) {
            final usuarioRepository = UsuarioRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            );
            return ProdutoBloc(
              produtoService: ProdutoServiceImpl(
                produtoRepository: ProdutoRepositoryImpl(
                  token: usuarioRepository.user.refreshToken.toString(),
                  produtos: [],
                ),
              ),
            );
          },
        ),

        //Carrinho
        BlocProvider<CarrinhoBloc>(
          create: (context) {
            final carrinhoRepository = CarrinhoRepositoryImpl();
            return CarrinhoBloc(
              carrinhoService: CarrinhoServiceImpl(
                carrinhoRepository: carrinhoRepository,
              ),
            );
          },
        ),
      ],
      child: const AppWidget(),
    );
  }
}
