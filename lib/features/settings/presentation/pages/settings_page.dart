import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_wallet/core/theme/app_colors.dart';
import 'package:mini_wallet/features/settings/presentation/controllers/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appTheme = controller.appTheme.value;
      final appLocale = controller.appLocale.value;
      final colors = _SettingsColors(
        isDark: Theme.of(context).brightness == Brightness.dark,
      );

      return Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _SettingsHeader(colors: colors),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _SettingsSection(
                    title: 'Appearance',
                    children: [
                      _ChoiceTile(
                        icon: Icons.light_mode_rounded,
                        title: 'Light mode',
                        subtitle: 'Use the bright wallet theme',
                        isSelected: appTheme == ThemeMode.light,
                        colors: colors,
                        onTap: () {
                          controller.onThemeChange(ThemeMode.light);
                        },
                      ),
                      _ChoiceTile(
                        icon: Icons.dark_mode_rounded,
                        title: 'Dark mode',
                        subtitle: 'Use the low-light wallet theme',
                        isSelected: appTheme == ThemeMode.dark,
                        colors: colors,
                        onTap: () {
                          controller.onThemeChange(ThemeMode.dark);
                        },
                      ),
                      _ChoiceTile(
                        icon: Icons.settings_suggest_rounded,
                        title: 'System default',
                        subtitle: 'Follow the device theme',
                        isSelected: appTheme == ThemeMode.system,
                        colors: colors,
                        onTap: () {
                          controller.onThemeChange(ThemeMode.system);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _SettingsSection(
                    title: 'Language',
                    children: [
                      _ChoiceTile(
                        icon: Icons.language_rounded,
                        title: 'English',
                        subtitle: 'United States',
                        isSelected: appLocale.languageCode == 'en',
                        colors: colors,
                        onTap: () {
                          controller.onLanguageChange(const Locale('en', 'US'));
                        },
                      ),
                      _ChoiceTile(
                        icon: Icons.translate_rounded,
                        title: 'Khmer',
                        subtitle: 'Cambodia',
                        isSelected: appLocale.languageCode == 'km',
                        colors: colors,
                        onTap: () {
                          controller.onLanguageChange(const Locale('km', 'KH'));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
                sliver: SliverToBoxAdapter(
                  child: _SettingsSection(
                    title: 'Logout',
                    children: [
                      _SignOutButton(
                        onTap: () {
                          controller.signOut();
                        },
                        isLoading: controller.isLogoutInProgress,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({required this.colors});

  final _SettingsColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconButtonSurface(
          icon: Icons.arrow_back_rounded,
          colors: colors,
          onTap: Get.back,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: Get.theme.textTheme.headlineSmall?.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Theme and language',
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(color: textColor),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final _SettingsColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? colors.accent : colors.border,
                width: isSelected ? 1.4 : 1,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected ? colors.accent : colors.surfaceMuted,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : colors.textPrimary,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isSelected ? colors.accent : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? colors.accent : colors.border,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 15,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButtonSurface extends StatelessWidget {
  const _IconButtonSurface({
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final IconData icon;
  final _SettingsColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surfaceMuted,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: colors.textPrimary, size: 21),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  final VoidCallback onTap;
  final RxBool isLoading;
  const _SignOutButton({required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Obx(() {
            if (isLoading.value) {
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      Get.theme.colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              );
            }

            return Center(child: Text("Sign Out"));
          }),
        ),
      ),
    );
  }
}

class _SettingsColors {
  const _SettingsColors({required this.isDark});

  final bool isDark;

  Color get background =>
      isDark ? AppColors.darkBackground : AppColors.background;

  Color get card => isDark ? AppColors.darkCard : AppColors.card;

  Color get surfaceMuted =>
      isDark ? AppColors.darkSurfaceMuted : AppColors.surfaceMuted;

  Color get border => isDark ? AppColors.darkBorder : AppColors.border;

  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

  Color get accent => isDark ? AppColors.darkSecondary : AppColors.secondary;
}
