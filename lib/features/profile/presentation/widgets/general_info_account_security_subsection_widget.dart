import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/features/common/presentation/widgets/horizontal_line_widget.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_router.dart';
import 'package:l3_flutter_selise_blocksconstruct/routing/app_routes.dart';
import 'package:l3_flutter_selise_blocksconstruct/theme/app_colors.dart';

import '../../../common/presentation/widgets/app_elevated_button.dart';
import '../providers/biometric_auth_provider.dart';

class GeneralInfoAccountSecuritySubsectionWidget extends ConsumerWidget {
  const GeneralInfoAccountSecuritySubsectionWidget({
    super.key,
    required this.isTwoFactorAuthenticationEnabled,
  });

  final bool isTwoFactorAuthenticationEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizationsContext = AppLocalizations.of(context)!;
    final isBiometricEnabled = ref.watch(biometricAuthProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(10),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Text(
              localizationsContext.accountSecurity,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          HorizontalLineWidget(),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizationsContext.twoFactorAuthentication,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizationsContext.twoFactorAuthenticationDescription,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
                AppElevatedButton(
                  onPressed: () {
                    if (isTwoFactorAuthenticationEnabled) return;
                    if (context.mounted) {
                      context.pushNamed(
                        AppRoutes.twoFactorAuth.name,
                        queryParameters: {'previousRoute': AppRoutes.profile.path},
                      );
                    }
                  },
                  title: isTwoFactorAuthenticationEnabled
                      ? localizationsContext.manage
                      : localizationsContext.enable,
                  leadingIcon: Icon(
                    Icons.verified_user_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  borderColor: AppColors.neutral90,
                  elevation: 0,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  borderRadius: 6,
                  isUppercase: false,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizationsContext.changePassword,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizationsContext.changePasswordDescription,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                      ),
                    ],
                  ),
                ),
                AppElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.changePassword.name,
                      queryParameters: {'previousRoute': AppRoutes.profile.path},
                    );
                  },
                  title: localizationsContext.updatePassword,
                  leadingIcon: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  borderColor: AppColors.neutral90,
                  elevation: 0,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  borderRadius: 6,
                  isUppercase: false,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizationsContext.enableBiometric,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizationsContext.biometricAuthDescription,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                AppElevatedButton(
                  onPressed: () {
                    if (context.mounted) {
                      context.pushNamed(
                        AppRoutes.enableBiometric.name,
                        queryParameters: {'previousRoute': AppRoutes.profile.path},
                      );
                    }
                  },
                  title:isBiometricEnabled
                      ? localizationsContext.disable
                      : localizationsContext.enable,
                  leadingIcon: Icon(
                    Icons.fingerprint,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  borderColor: AppColors.neutral90,
                  elevation: 0,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  borderRadius: 6,
                  isUppercase: false,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
