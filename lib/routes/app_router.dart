import 'package:go_router/go_router.dart';
import 'package:mini_wallet/features/add_transaction/bindings/add_transaction_binding.dart';
import 'package:mini_wallet/features/add_transaction/presentation/pages/add_transaction_page.dart';
import 'package:mini_wallet/features/edit_transaction/bindings/edit_transaction_binding.dart';
import 'package:mini_wallet/features/edit_transaction/presentation/pages/edit_transaction_page.dart';
import 'package:mini_wallet/features/home/bindings/home_binding.dart';
import 'package:mini_wallet/features/home/presentation/pages/home_page.dart';
import 'package:mini_wallet/features/shell/presentation/pages/app_shell_page.dart';
import 'package:mini_wallet/features/transaction_details/bindings/transaction_details_binding.dart';
import 'package:mini_wallet/features/transaction_details/presentation/pages/transaction_details_page.dart';
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
              HomeBinding().dependencies();
              return const HomePage();
            },
          ),
          GoRoute(
            path: RoutePaths.addTransaction,
            name: RouteNames.addTransaction,
            builder: (context, state) {
              AddTransactionBinding().dependencies();
              return const AddTransactionPage();
            },
          ),
          GoRoute(
            path: RoutePaths.editTransaction,
            name: RouteNames.editTransaction,
            builder: (context, state) {
              EditTransactionBinding().dependencies();
              return const EditTransactionPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.transactionDetails,
        name: RouteNames.transactionDetails,
        builder: (context, state) {
          TransactionDetailsBinding().dependencies();
          return const TransactionDetailsPage();
        },
      ),
    ],
  );
}
