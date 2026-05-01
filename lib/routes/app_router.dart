import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';
import 'package:mini_wallet/features/auth/bindings/login_binding.dart';
import 'package:mini_wallet/features/auth/bindings/register_binding.dart';
import 'package:mini_wallet/features/auth/presentation/pages/login_page.dart';
import 'package:mini_wallet/features/auth/presentation/pages/register_page.dart';
import 'package:mini_wallet/features/transaction/bindings/add_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/edit_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/home_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/transaction_details_binding.dart';
import 'package:mini_wallet/core/widgets/binding_scope.dart';
import 'package:mini_wallet/features/transaction/data/models/transaction_model.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/add_transaction_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/edit_transaction_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/home_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/transaction_details_page.dart';
import 'package:mini_wallet/routes/route_names.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class AppRouter {
  AppRouter._();

  static final _tokenStorage = SecureTokenStorage(const FlutterSecureStorage());

  static final routerConfig = GoRouter(
    initialLocation: RoutePaths.home,

    redirect: (context, state) async {
      final accessToken = await _tokenStorage.getAccessToken();
      final isLoggedIn = accessToken != null && accessToken.trim().isNotEmpty;

      final location = state.matchedLocation;

      final isAuthRoute =
          location == RoutePaths.login || location == RoutePaths.register;

      if (!isLoggedIn && !isAuthRoute) {
        return RoutePaths.login;
      }

      if (isLoggedIn && isAuthRoute) {
        return RoutePaths.home;
      }

      return null;
    },

    routes: [
      // ShellRoute(
      //   builder: (context, state, child) {
      //     return AppShellPage(child: child);
      //   },
      //   routes: [
      //     GoRoute(
      //       path: RoutePaths.home,
      //       name: RouteNames.home,
      //       builder: (context, state) {
      //         return BindingScope(
      //           binding: HomeBinding(),
      //           child: const HomePage(),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: RoutePaths.addTransaction,
      //       name: RouteNames.addTransaction,
      //       builder: (context, state) {
      //         return BindingScope(
      //           binding: AddTransactionBinding(),
      //           child: const AddTransactionPage(),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: RoutePaths.editTransaction,
      //       name: RouteNames.editTransaction,
      //       builder: (context, state) {
      //         return BindingScope(
      //           binding: EditTransactionBinding(),
      //           child: const EditTransactionPage(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) {
          return BindingScope(
            binding: LoginBinding(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) {
          return BindingScope(
            binding: RegisterBinding(),
            child: const RegisterPage(),
          );
        },
      ),

      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) {
          return BindingScope(binding: HomeBinding(), child: const HomePage());
        },
      ),
      GoRoute(
        path: RoutePaths.addTransaction,
        name: RouteNames.addTransaction,
        builder: (context, state) {
          return BindingScope(
            binding: AddTransactionBinding(),
            child: const AddTransactionPage(),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.editTransaction,
        name: RouteNames.editTransaction,
        builder: (context, state) {
          final transaction = state.extra;
          return BindingScope(
            binding: EditTransactionBinding(
              transaction: transaction is TransactionModel ? transaction : null,
            ),
            child: const EditTransactionPage(),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.transactionDetails,
        name: RouteNames.transactionDetails,
        builder: (context, state) {
          final transaction = state.extra;
          if (transaction is! TransactionModel) {
            throw ArgumentError(
              'TransactionDetailsPage requires a TransactionModel in state.extra.',
            );
          }

          return BindingScope(
            binding: TransactionDetailsBinding(transaction: transaction),
            child: const TransactionDetailsPage(),
          );
        },
      ),
    ],
  );
}
