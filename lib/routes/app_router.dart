import 'package:go_router/go_router.dart';
import 'package:mini_wallet/features/transaction/bindings/add_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/edit_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/home_binding.dart';
import 'package:mini_wallet/features/shell/presentation/pages/app_shell_page.dart';
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

  static final routerConfig = GoRouter(
    initialLocation: RoutePaths.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppShellPage(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            builder: (context, state) {
              return BindingScope(
                binding: HomeBinding(),
                child: const HomePage(),
              );
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
              return BindingScope(
                binding: EditTransactionBinding(),
                child: const EditTransactionPage(),
              );
            },
          ),
        ],
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

          return TransactionDetailsPage(transaction: transaction);
        },
      ),
    ],
  );
}
