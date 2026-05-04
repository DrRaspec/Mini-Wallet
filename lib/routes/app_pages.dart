import 'package:get/get.dart';
import 'package:mini_wallet/features/auth/bindings/login_binding.dart';
import 'package:mini_wallet/features/auth/bindings/register_binding.dart';
import 'package:mini_wallet/features/auth/presentation/pages/login_page.dart';
import 'package:mini_wallet/features/auth/presentation/pages/register_page.dart';
import 'package:mini_wallet/features/settings/bindings/settings_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/add_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/edit_transaction_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/home_binding.dart';
import 'package:mini_wallet/features/transaction/bindings/transaction_details_binding.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/add_transaction_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/edit_transaction_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/home_page.dart';
import 'package:mini_wallet/features/transaction/presentation/pages/transaction_details_page.dart';
import 'package:mini_wallet/features/settings/presentation/pages/settings_page.dart';
import 'package:mini_wallet/routes/app_routes.dart';
import 'package:mini_wallet/routes/auth_middleware.dart';

class AppPages {
  AppPages._();

  static final _authMiddleware = AuthMiddleware(priority: 1);

  static final pages = [
    // Auth Pages
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      middlewares: [_authMiddleware],
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      middlewares: [_authMiddleware],
    ),

    // Transaction Pages
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [_authMiddleware],
    ),

    GetPage(
      name: AppRoutes.addTransaction,
      page: () => const AddTransactionPage(),
      binding: AddTransactionBinding(),
      middlewares: [_authMiddleware],
    ),

    GetPage(
      name: AppRoutes.transactionDetails,
      page: () => const TransactionDetailsPage(),
      binding: TransactionDetailsBinding(),
      middlewares: [_authMiddleware],
    ),

    GetPage(
      name: AppRoutes.editTransaction,
      page: () => const EditTransactionPage(),
      binding: EditTransactionBinding(),
      middlewares: [_authMiddleware],
    ),

    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
      middlewares: [_authMiddleware],
    ),
  ];
}
