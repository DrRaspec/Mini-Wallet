import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/auth/presentation/controllers/register_controller.dart';
import 'package:mini_wallet/routes/route_names.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.goNamed(RouteNames.login)),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create account',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start tracking your money with a fresh wallet.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                _RegisterFormCard(controller: controller),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed(RouteNames.login),
                      child: const Text('Login'),
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

class _RegisterFormCard extends StatelessWidget {
  const _RegisterFormCard({required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FieldLabel(label: 'Username', theme: theme),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.usernameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter your username',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username is required';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            _FieldLabel(label: 'Password', theme: theme),
            const SizedBox(height: 8),
            Obx(
              () => TextFormField(
                controller: controller.passwordController,
                obscureText: !controller.passwordVisible.value,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Create a password',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      controller.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                    ),
                    onTap: () => controller.passwordVisible.toggle(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            _FieldLabel(label: 'Confirm password', theme: theme),
            const SizedBox(height: 8),
            Obx(
              () => TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.confirmPasswordVisible.value,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Repeat your password',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: GestureDetector(
                    child: Icon(
                      controller.confirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                    ),
                    onTap: () => controller.confirmPasswordVisible.toggle(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.value) return;

                    final success = await controller.submitRegister();

                    if (!context.mounted || !success) return;

                    context.go(RoutePaths.home);
                  },
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: theme.colorScheme.onPrimary,
                        )
                      : const Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
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
        color: AppColors.textPrimary,
      ),
    );
  }
}
