import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/core/translations/app_keys.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/login_controller.dart';
import 'package:mini_wallet/routes/app_routes.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AuthMark(),
                const SizedBox(height: 36),
                Text(
                  AppKeys.welcomeMessage.tr,
                  style: Get.theme.textTheme.headlineLarge?.copyWith(
                    color: context.appTextPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppKeys.loginTitle.tr,
                  style: Get.theme.textTheme.bodyMedium?.copyWith(
                    color: context.appTextSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                _LoginFormCard(controller: controller),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppKeys.newUser.tr,
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: context.appTextSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: Text(AppKeys.createAccountButton.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginFormCard extends StatefulWidget {
  const _LoginFormCard({required this.controller});

  final LoginController controller;

  @override
  State<_LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<_LoginFormCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.appCard,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FieldLabel(label: AppKeys.username.tr, theme: theme),
            const SizedBox(height: 8),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: AppKeys.usernameHint.tr,
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppKeys.usernameRequired.tr;
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            _FieldLabel(label: AppKeys.password.tr, theme: theme),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: AppKeys.passwordHint.tr,
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: Icon(Icons.visibility_off_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppKeys.passwordRequired.tr;
                }

                return null;
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(AppKeys.forgotPassword.tr),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (widget.controller.isLoading.value) return;
                    if (!(_formKey.currentState?.validate() ?? false)) return;

                    final success = await widget.controller.submitLogin(
                      _usernameController.text.trim(),
                      _passwordController.text,
                    );

                    if (!context.mounted || !success) return;

                    Get.offAllNamed(AppRoutes.home);
                  },
                  child: widget.controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: context.theme.colorScheme.onPrimary,
                        )
                      : Text(AppKeys.loginButton.tr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthMark extends StatelessWidget {
  const _AuthMark();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: context.appSecondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          AppKeys.appName.tr,
          style: theme.textTheme.titleLarge?.copyWith(
            color: context.appTextPrimary,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.theme});

  final String label;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
        color: context.appTextPrimary,
      ),
    );
  }
}
