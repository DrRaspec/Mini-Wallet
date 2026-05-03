import 'package:get/get.dart';
import 'package:mini_wallet/core/storage/secure_token_storage.dart';
import 'package:mini_wallet/routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  AuthMiddleware({super.priority});

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final tokenStorage = Get.find<SecureTokenStorage>();
    final accessToken = await tokenStorage.getAccessToken();

    final isLoggedIn = accessToken != null && accessToken.trim().isNotEmpty;
    final currentRoute = route.currentPage?.name;

    final isAuthRoute =
        currentRoute == AppRoutes.login || currentRoute == AppRoutes.register;

    if (!isLoggedIn && !isAuthRoute) {
      return GetNavConfig.fromRoute(AppRoutes.login);
    }

    if (isLoggedIn && isAuthRoute) {
      return GetNavConfig.fromRoute(AppRoutes.home);
    }

    return route;
  }
}
